"""Regression checks for restored A1 feedback; no private solutions required."""
import hashlib
import json
from pathlib import Path
import runpy
import sqlite3
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
G = runpy.run_path(str(ROOT / '.github/scripts/grade_assignment1.py'))


class Assignment1RegressionTests(unittest.TestCase):
    def submission(self, text):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'assignment1.sql'
            path.write_text(text)
            return G['run_assignment'](path)

    def test_execution_is_not_correctness_and_errors_do_not_hide_later_answers(self):
        results = self.submission('-- QUERY 1\nSELECT 1 AS wrong_answer;\n-- END QUERY\n'
                                  '--QUERY 2\nSELECT * FROM no_such_table;\n--END QUERY\n'
                                  '--QUERY 3\nSELECT * FROM customer;\n--END QUERY')
        self.assertEqual(results[0]['status'], 'executed')
        self.assertIn('instructor review', results[0]['feedback'])
        self.assertEqual(results[1]['status'], 'error')
        self.assertEqual(results[2]['status'], 'executed')
        self.assertEqual(len(results[2]['result']), 3)
        self.assertTrue(all(r['status'] == 'missing' for r in results[3:]))

    def test_historical_multistatement_and_end_statement_preserve_state(self):
        results = self.submission("--QUERY 10\nCREATE TEMP TABLE sample(value);\n"
                                  "INSERT INTO sample VALUES ('Pie; special'); -- comment;\n"
                                  "SELECT * FROM sample;\n--END STATEMENT\n"
                                  "--QUERY 11\nSELECT * FROM sample;\n--END QUERY")
        for number in (10, 11):
            self.assertEqual(results[number-1]['result'], [{'value': 'Pie; special'}])

    def test_empty_and_comment_only_answers_are_missing(self):
        for text in ('', '--QUERY 1\n-- no answer\n/* empty */;\n--END QUERY'):
            self.assertTrue(all(r['status'] == 'missing' for r in self.submission(text)))

    def test_malformed_or_missing_submissions_replace_stale_reports(self):
        for text in ('--QUERY 1\nSELECT 1', '--QUERY nope', '--QUERY 99\n--END QUERY',
                     '--QUERY 1\n--QUERY 2', '--END QUERY',
                     '--QUERY 1\n--END QUERY\n--QUERY 1\n--END QUERY'):
            with self.subTest(text=text), tempfile.TemporaryDirectory() as directory:
                path = Path(directory) / 'assignment1.sql'
                path.write_text(text)
                output = Path(directory) / 'report.json'
                output.write_text('[{"stale": true}]')
                self.assertEqual(G['grade_files']([str(path)], output), 1)
                report = json.loads(output.read_text())[0]
                self.assertTrue(report['runner_error'])
                self.assertEqual(report['results'], [])
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'report.json'
            for files in ([], ['one/assignment1.sql', 'two/assignment1.sql'], ['missing/assignment1.sql']):
                self.assertEqual(G['grade_files'](files, output), 1)
                self.assertTrue(json.loads(output.read_text())[0]['runner_error'])

    def test_database_is_unchanged_and_disk_attachment_is_denied(self):
        database = ROOT / '05_src/sql/farmersmarket.db'
        before = hashlib.sha256(database.read_bytes()).digest()
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / 'disk.db'
            results = self.submission(f"--QUERY 1\nATTACH DATABASE '{target}' AS disk;\n--END QUERY")
            self.assertEqual(results[0]['status'], 'error')
            self.assertFalse(target.exists())
        self.submission('--QUERY 1\nDELETE FROM customer;\n--END QUERY')
        self.assertEqual(hashlib.sha256(database.read_bytes()).digest(), before)

    def test_long_query_is_interrupted(self):
        conn = sqlite3.connect(':memory:')
        try:
            ticks = iter((0, 11))
            with patch('time.monotonic', side_effect=lambda: next(ticks, 11)):
                with self.assertRaises(sqlite3.OperationalError):
                    G['run_query'](conn, 'WITH RECURSIVE n(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM n WHERE x<10000000) SELECT SUM(x) FROM n;')
        finally:
            conn.close()

    def test_cli_selects_a1_from_mixed_assignment_changes(self):
        with tempfile.TemporaryDirectory() as directory:
            directory = Path(directory)
            # A space in the path verifies NUL-delimited selection as well.
            submission = directory / 'cohort with spaces' / 'assignment1.sql'
            submission.parent.mkdir()
            submission.write_text('--QUERY 1\nSELECT 1 AS value;\n--END QUERY')
            changed = directory / 'changed.txt'
            changed.write_bytes(f'other/assignment2.sql\0{submission}\0'.encode())
            output = directory / 'result.json'
            result = subprocess.run([sys.executable, '.github/scripts/grade_assignment1.py',
                                     str(changed), str(output)], check=False)
            self.assertEqual(result.returncode, 0)
            report = json.loads(output.read_text())[0]
            self.assertEqual(report['file'], str(submission))
            self.assertEqual(report['results'][0]['status'], 'executed')


if __name__ == '__main__':
    unittest.main()
