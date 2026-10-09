"""Check that the autograder makes the right marking decisions.

Public checks cover runner safety without exposing answers. When the private staff
rubric is supplied through A2_SOLUTION_RUBRIC, the same suite also creates correct
and deliberately wrong submissions to test every marking decision end to end.
All sample submissions and reports are created in temporary folders.
"""
from pathlib import Path
import hashlib
import json
import os
import re
import runpy
import sqlite3
import tempfile
import unittest
from unittest.mock import patch

# Find the repository root, regardless of where this test file is launched from.
REPO = Path(__file__).resolve().parents[2]
# Load the real grader functions so these tests exercise the code used for marking.
G = runpy.run_path(str(Path(__file__).with_name("test_assignment.py")))
SOLUTION_RUBRIC = os.environ.get("A2_SOLUTION_RUBRIC")
requires_private_solution = unittest.skipUnless(
    SOLUTION_RUBRIC,
    "Set A2_SOLUTION_RUBRIC to run private solution-based regression tests.",
)


class GraderRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        """Prepare the course database and optional private answers once for all tests."""
        cls.path = REPO / "05_src/sql/farmersmarket.db"
        # Save a fingerprint of the database so we can detect accidental changes.
        cls.original = hashlib.sha256(cls.path.read_bytes()).hexdigest()
        # Read-only access protects the original; the grader works on copies.
        cls.source = sqlite3.connect(f"file:{cls.path}?mode=ro", uri=True)
        cls.blocks = []
        cls.valid = {}
        if SOLUTION_RUBRIC:
            # The private rubric includes explanations and multiple valid answers.
            rubric = Path(SOLUTION_RUBRIC).read_text()
            cls.blocks = re.findall(r"```\n(.*?)```", rubric, re.S)
            # These positions pick one correct answer for each of the 12 questions.
            cls.valid = dict(zip(range(1, 13), [cls.blocks[i].strip() for i in
                                             (1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 16)]))

    @classmethod
    def tearDownClass(cls):
        """Close the database and confirm that testing did not change the original file."""
        cls.source.close()
        assert hashlib.sha256(cls.path.read_bytes()).hexdigest() == cls.original

    def run_submission(self, changes=None, text=None):
        """Make a temporary submission, run the grader, and return its feedback by question."""
        with tempfile.TemporaryDirectory() as folder:
            folder = Path(folder)
            submission = folder / "assignment2.sql"
            # Start with correct answers and replace only the questions being tested.
            # Supplying raw text instead lets us test missing or broken query markers.
            answers = self.valid | (changes or {})
            if text is None:
                if not self.valid:
                    raise RuntimeError("Private solution rubric is required for this test.")
                text = "\n".join(f"--QUERY {n}\n{sql}\n--END QUERY" for n, sql in answers.items())
            submission.write_text(text)
            report = folder / "report.json"
            # Plant an old report first: every run must replace it with fresh feedback.
            report.write_text('[{"stale": true}]')
            G["run_assignment"](self.source, submission, report)
            results = json.loads(report.read_text())
            # Every report must account for all 12 questions, even if answers are missing.
            self.assertEqual([r["number"] for r in results], list(range(1, 13)))
            return {r["number"]: r for r in results}

    @requires_private_solution
    def test_all_instructor_answers_pass_without_timestamp_sleep(self):
        """Correct instructor answers should all pass, even when run immediately in sequence."""
        self.assertTrue(all(r["status"] == "correct" for r in self.run_submission().values()))

    @requires_private_solution
    def test_wrong_answers_are_rejected_with_valid_prerequisites(self):
        """Give each question a wrong answer while keeping the other answers correct."""
        wrong = {
            1: 'SELECT product_name FROM product',
            2: 'SELECT customer_id,market_date,99 AS visit_number FROM customer_purchases',
            3: 'SELECT customer_id,market_date,99 AS visit_number FROM customer_purchases',
            4: 'SELECT *,99 AS product_purchase_count FROM customer_purchases',
            5: 'SELECT product_name,NULL AS description FROM product',
            6: 'SELECT * FROM product',
            7: 'SELECT market_date,0 AS sales FROM customer_purchases GROUP BY market_date LIMIT 2',
            8: 'SELECT vendor_name,product_name,0 AS revenue FROM vendor CROSS JOIN product',
            9: self.valid[9].replace('WHERE product_qty_type = "unit"', ''),
            10: 'SELECT 1', 11: 'DELETE FROM product_units WHERE 1=0',
            12: 'ALTER TABLE product_units ADD current_quantity INT; UPDATE product_units SET current_quantity=-1;',
        }
        # Test one wrong answer at a time so an earlier failure cannot hide the result.
        for number, sql in wrong.items():
            with self.subTest(question=number):
                self.assertEqual(self.run_submission({number: sql})[number]['status'], 'incorrect')

    def test_missing_blank_and_comment_only_answers_are_explicit(self):
        """An empty file, comments, or omitted questions must be reported as missing answers."""
        for text in ('', '--QUERY 1\n-- unanswered\n--END QUERY'):
            with self.subTest(text=text):
                self.assertTrue(all(r['status'] == 'missing' for r in self.run_submission(text=text).values()))
        results = self.run_submission(text='--QUERY 1\nSELECT 1\n--END QUERY')
        self.assertEqual(results[12]['status'], 'missing')

    def test_malformed_submissions_always_replace_stale_report(self):
        """Broken query markers must produce fresh errors rather than reuse an old report."""
        for text in ('--QUERY 1\nSELECT 1', '--QUERY 1\nSELECT 1\n--END QUERY\n--QUERY 1\nSELECT 1\n--END QUERY',
                     '--QUERY 99\nSELECT 1\n--END QUERY', '--QUERY nope', '--END QUERY',
                     '--QUERY 1\n--QUERY 2'):
            with self.subTest(text=text):
                self.assertTrue(all(r['status'] == 'error' for r in self.run_submission(text=text).values()))

    @requires_private_solution
    def test_valid_window_alternatives(self):
        """Accept the different visit-numbering and purchase-count approaches allowed by A2."""
        for number, index in ((2, 3), (3, 5), (4, 7)):
            with self.subTest(question=number):
                self.assertEqual(self.run_submission({number: self.blocks[index]})[number]['status'], 'correct')

    def test_semicolons_inside_literals_and_comments(self):
        """A semicolon in a product name or comment must not break a valid SQL command."""
        conn = G['clone_database'](self.source)
        try:
            rows = G['run_query'](conn, "CREATE TEMP TABLE sample(value); INSERT INTO sample VALUES ('Pie; special'); -- comment;\n SELECT * FROM sample;; -- trailing;\n;")
            self.assertEqual(rows, [{'value': 'Pie; special'}])
        finally:
            conn.close()

    @requires_private_solution
    def test_techniques_cannot_be_satisfied_by_comments_or_literals(self):
        """Mentioning REGEXP or UNION in comments or text does not count as using it."""
        sql = "SELECT * FROM product WHERE product_size GLOB '*[0-9]*' -- REGEXP"
        self.assertEqual(self.run_submission({6: sql})[6]['status'], 'incorrect')
        self.assertIsNotNone(G['technique_feedback'](7, "SELECT 'UNION' /* UNION */"))
        self.assertIsNone(G['technique_feedback'](7, self.valid[7]))

    @requires_private_solution
    def test_description_alias_is_accepted(self):
        """Accept correct Q5 descriptions when the student chooses a different column alias."""
        sql, replacements = re.subn(r'\bAS\s+description\b', 'AS product_description',
                                    self.valid[5], flags=re.I)
        self.assertEqual(replacements, 1)
        self.assertEqual(self.run_submission({5: sql})[5]['status'], 'correct')

    @requires_private_solution
    def test_sales_alias_and_dates_only_are_accepted(self):
        """Accept a different sales column name or an answer showing just the requested dates."""
        alias = self.valid[7].replace('sales, sales_rank_desc AS sales_rank', 'sales AS gross_income, sales_rank_desc AS sales_rank')
        date_only = re.sub(r'SELECT market_date, sales, sales_rank_desc AS sales_rank', 'SELECT market_date', self.valid[7])
        for sql in (alias, date_only):
            self.assertEqual(self.run_submission({7: sql})[7]['status'], 'correct')

    @requires_private_solution
    def test_reordered_snapshot_columns(self):
        """Putting the required product columns in a different order should still pass."""
        sql = self.valid[9].replace('p.*', 'product_name,product_id,product_size,product_category_id,product_qty_type')
        self.assertEqual(self.run_submission({9: sql})[9]['status'], 'correct')

    @requires_private_solution
    def test_invalid_and_stale_timestamps_fail(self):
        """Reject timestamps that are meaningless text or dates far in the past."""
        for n, value in ((9, "'not a timestamp'"), (10, "'1900-01-01'")):
            self.assertEqual(self.run_submission({n: self.valid[n].replace('CURRENT_TIMESTAMP', value)})[n]['status'], 'incorrect')

    @requires_private_solution
    def test_current_datetime_forms_use_the_same_controlled_clock(self):
        """Equivalent ways to get the current time must follow the same grading clock."""
        for expression in ("DATETIME('now')", "STRFTIME('%Y-%m-%d %H:%M:%S','now')"):
            changes = {n: self.valid[n].replace('CURRENT_TIMESTAMP', expression) for n in (9, 10)}
            results = self.run_submission(changes)
            self.assertTrue(all(results[n]['status'] == 'correct' for n in (9, 10, 11)))

    @requires_private_solution
    def test_inserted_copy_cannot_have_an_older_timestamp(self):
        """A newly inserted copy must not be dated earlier than the original copy."""
        expression = "DATETIME((SELECT MIN(snapshot_timestamp) FROM product_units WHERE product_id=7), '-1 second')"
        results = self.run_submission({10: self.valid[10].replace('CURRENT_TIMESTAMP', expression)})
        self.assertEqual(results[10]['status'], 'incorrect')

    @requires_private_solution
    def test_new_product_is_accepted_and_ambiguous_delete_needs_review(self):
        """Allow a new product; ask an instructor to assess deletion when no older copy exists."""
        results = self.run_submission({10: "INSERT INTO product_units VALUES (999,'New Pie','10 inch',3,'unit',CURRENT_TIMESTAMP)",
                                       11: 'DELETE FROM product_units WHERE 1=0'})
        self.assertEqual(results[10]['status'], 'correct')
        self.assertEqual(results[11]['status'], 'manual_review')
        self.assertEqual(results[12]['status'], 'correct')

    @requires_private_solution
    def test_delete_must_keep_inserted_copy(self):
        """Deleting both product copies must fail: the newer copy needs to remain."""
        self.assertEqual(self.run_submission({11: 'DELETE FROM product_units WHERE product_id=7'})[11]['status'], 'incorrect')

    @requires_private_solution
    def test_equal_timestamps_allow_one_copy_to_survive(self):
        """When timestamps tie, accept deleting the original row and reject deleting the newer row."""
        same = self.valid[10].replace('CURRENT_TIMESTAMP', '(SELECT MIN(snapshot_timestamp) FROM product_units WHERE product_id=7)')
        one = 'DELETE FROM product_units WHERE rowid=(SELECT MIN(rowid) FROM product_units WHERE product_id=7)'
        self.assertEqual(self.run_submission({10: same, 11: one})[11]['status'], 'correct')
        self.assertEqual(self.run_submission({10: same})[11]['status'], 'incorrect')
        newer = one.replace('MIN(rowid)', 'MAX(rowid)')
        self.assertEqual(self.run_submission({10: same, 11: newer})[11]['status'], 'incorrect')

    @requires_private_solution
    def test_update_cannot_delete_or_modify_other_values(self):
        """Updating quantities must not erase products or change their other details."""
        for sql in ('ALTER TABLE product_units ADD current_quantity INT; DELETE FROM product_units;',
                    self.valid[12] + "; UPDATE product_units SET product_name='Changed';"):
            self.assertEqual(self.run_submission({12: sql})[12]['status'], 'incorrect')

    def test_prerequisite_failure_is_distinguished_from_wrong_answer(self):
        """If table creation fails, explain that later questions cannot be assessed yet."""
        text = '--QUERY 9\nCREATE TABLE product_units AS SELECT * FROM missing_table\n--END QUERY'
        text += ''.join(f'\n--QUERY {n}\nSELECT 1;\n--END QUERY' for n in (10, 11, 12))
        results = self.run_submission(text=text)
        self.assertEqual(results[9]['status'], 'error')
        self.assertTrue(all(results[n]['status'] == 'blocked' for n in (10, 11, 12)))

    def test_sql_cannot_attach_disk_database(self):
        """Student SQL must not open another database file and write to it."""
        with tempfile.TemporaryDirectory() as folder:
            target = Path(folder) / 'disk.db'
            text = f"--QUERY 1\nATTACH DATABASE '{target}' AS disk; CREATE TABLE disk.test(value);\n--END QUERY"
            results = self.run_submission(text=text)
            self.assertEqual(results[1]['status'], 'error')
            self.assertFalse(target.exists())

    def test_long_sql_is_interrupted(self):
        """Stop an excessively long query instead of letting it run without a time limit."""
        conn = G['clone_database'](self.source)
        # Pretend time has advanced past the limit, avoiding a real ten-second wait.
        ticks = iter((0, 11))
        try:
            with patch('time.monotonic', side_effect=lambda: next(ticks, 11)):
                with self.assertRaises(sqlite3.OperationalError):
                    G['run_query'](conn, "WITH RECURSIVE n(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM n WHERE x<10000000) SELECT SUM(x) FROM n;")
        finally:
            conn.close()

    def test_runner_requires_one_file_and_reports_failures(self):
        """Require one submission file and give explicit feedback for selection or runner failures."""
        runner = runpy.run_path(str(REPO / '.github/scripts/grade_assignments.py'))
        with tempfile.TemporaryDirectory() as folder:
            output = Path(folder) / 'combined.json'
            calls = []
            # Stand in for pytest here so we can inspect which files the runner selects.
            # The other tests exercise the actual grader; this one tests orchestration.
            def fake_run(command, **kwargs):
                calls.append(command)
                report = Path(next(arg.split('=', 1)[1] for arg in command if arg.startswith('--report_path=')))
                report.write_text(json.dumps([{'number': n} for n in range(1, 13)]))
                return type('Result', (), {'returncode': 0})()
            with patch('subprocess.run', fake_run):
                self.assertEqual(runner['grade_files'](['DC/assignment2.sql'], output), 0)
            self.assertEqual(len(calls), 1)
            self.assertEqual(len(json.loads(output.read_text())), 1)
            for files, message in (([], 'No changed'),
                                   (['DC/assignment2.sql', 'Micro/assignment2.sql'], 'More than one')):
                with self.subTest(files=files), patch('subprocess.run', fake_run):
                    calls.clear()
                    self.assertEqual(runner['grade_files'](files, output), 1)
                    self.assertFalse(calls)
                    self.assertIn(message, json.loads(output.read_text())[0]['runner_error'])
            # Simulate a runner crash and check that an old success report is replaced.
            with patch('subprocess.run', side_effect=RuntimeError('Runner unavailable')):
                self.assertEqual(runner['grade_files'](['DC/assignment2.sql'], output), 1)
            self.assertIn('Runner unavailable', json.loads(output.read_text())[0]['runner_error'])


if __name__ == '__main__':
    unittest.main()
