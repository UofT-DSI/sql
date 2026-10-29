"""Restore A1 execution feedback from tests/test_assignment.py at 3fe0023^.

As in the historical runner, this executes SQL and shows up to three rows;
it does not award marks or establish answer correctness.
"""
import json
from pathlib import Path
import re
import sqlite3
import sys
import time

DATABASE = Path("05_src/sql/farmersmarket.db")


def load_queries(sql_file):
    """Read the historical QUERY / END QUERY (or END STATEMENT) blocks."""
    queries = {}
    number = None
    buffer = []
    for line in Path(sql_file).read_text().splitlines():
        stripped = line.strip()
        start = re.fullmatch(r"--\s*QUERY\s+(\d+)\s*", stripped, re.I)
        end = re.fullmatch(r"--\s*END\s+(?:QUERY|STATEMENT)\s*", stripped, re.I)
        if start:
            if number is not None:
                raise ValueError("Nested or unclosed QUERY block.")
            number = int(start[1])
            if number not in range(1, 13) or number in queries:
                raise ValueError(f"Unknown or duplicate QUERY number: {number}.")
            buffer = []
        elif end:
            if number is None:
                raise ValueError("END marker has no matching QUERY marker.")
            queries[number] = "\n".join(buffer).strip()
            number = None
        elif re.match(r"--\s*(QUERY|END\s+(?:QUERY|STATEMENT))\b", stripped, re.I):
            raise ValueError(f"Invalid answer marker: {stripped}")
        elif number is not None:
            buffer.append(line)
    if number is not None:
        raise ValueError(f"QUERY {number} has no END marker.")
    return [{"number": n, "query": queries.get(n, "")} for n in range(1, 13)]


def has_sql(query):
    return bool(re.sub(r"--[^\n]*|/\*[\s\S]*?\*/|[\s;]+", "", query))


def run_query(conn, query):
    """Keep multistatement support without splitting quoted semicolons."""
    deadline = time.monotonic() + 10
    conn.set_progress_handler(lambda: int(time.monotonic() > deadline), 1000)
    cursor = conn.cursor()
    buffer = ""
    try:
        for character in query:
            buffer += character
            if character == ";" and sqlite3.complete_statement(buffer):
                if has_sql(buffer):
                    cursor.execute(buffer)
                buffer = ""
        if has_sql(buffer):
            cursor.execute(buffer)
        return [dict(row) for row in cursor.fetchmany(3)]
    finally:
        conn.set_progress_handler(None, 0)


def run_assignment(file_path):
    """Execute on a disposable database, retaining state between A1 blocks."""
    queries = load_queries(file_path)
    conn = sqlite3.connect(":memory:")
    conn.row_factory = sqlite3.Row
    try:
        with sqlite3.connect(f"file:{DATABASE}?mode=ro", uri=True) as source:
            source.backup(conn)
        conn.set_authorizer(lambda action, *_: sqlite3.SQLITE_DENY
                            if action in (sqlite3.SQLITE_ATTACH, sqlite3.SQLITE_DETACH)
                            else sqlite3.SQLITE_OK)
        results = []
        for parsed in queries:
            result = dict(parsed, result=[], error=None)
            if not has_sql(parsed["query"]):
                result.update(status="missing", feedback="No SQL answer supplied.")
            else:
                try:
                    result["result"] = run_query(conn, parsed["query"])
                    result.update(status="executed", feedback="SQL executed. Correctness requires instructor review.")
                except Exception as error:
                    result.update(status="error", feedback="SQL could not execute.", error=str(error))
            results.append(result)
        return results
    finally:
        conn.close()


def grade_files(files, output):
    """Require one cohort's A1 file and always replace stale reports."""
    report = {"file": "Submission selection", "results": [], "runner_error": None}
    try:
        if len(files) != 1:
            raise ValueError("No changed assignment1.sql file was found." if not files else
                             "More than one assignment1.sql file changed. Submit only your cohort's file.")
        report["file"] = files[0]
        report["results"] = run_assignment(files[0])
    except Exception as error:
        report["runner_error"] = str(error)
    Path(output).write_text(json.dumps([report], indent=2))
    return int(report["runner_error"] is not None)


if __name__ == "__main__":
    changed = Path(sys.argv[1]).read_bytes().decode().split("\0")
    files = sorted({path for path in changed if Path(path).name == "assignment1.sql"})
    sys.exit(grade_files(files, sys.argv[2]))
