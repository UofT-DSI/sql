import json
from pathlib import Path
import sqlite3
import re

def load_queries(sql_file):
    lines = Path(sql_file).read_text().splitlines()

    queries = []
    current_query = None
    buffer = []

    for line in lines:
        stripped = line.strip()

        # Start marker: -- QUERY <n>
        if stripped.lower().startswith("--query"):
            if current_query is not None:
                raise AssertionError("Nested QUERY blocks are not allowed")

            parts = stripped.split()
            if len(parts) < 2:
                raise AssertionError(f"Invalid QUERY marker: {line}")

            try:
                current_query = int(parts[1])
            except ValueError:
                raise AssertionError(f"Invalid QUERY number: {line}")

            buffer = []
            continue

        # End marker: -- END QUERY or -- END STATEMENT
        if stripped.lower().startswith("--end"):
            if current_query is None:
                continue  # ignore stray END

            query = "\n".join(buffer).strip().rstrip(";")

            queries.append({
                "number": current_query,
                "query": query
            })

            current_query = None
            buffer = []
            continue

        # Collect lines inside a query block
        if current_query is not None:
            buffer.append(line)

    if not queries:
        raise AssertionError(
            "No queries found. Use '-- QUERY <n>' and '-- END QUERY' markers."
        )

    return queries

def run_query(conn, query):
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return [dict(row) for row in rows]

    except sqlite3.ProgrammingError as e:
        if "one statement at a time" in str(e).lower():
            # fallback: handle multiple statements
            statements = [s.strip() for s in query.split(";") if s.strip()]

            if len(statements) == 0:
                return []

            for stmt in statements[:-1]:
                cursor.execute(stmt)

            cursor.execute(statements[-1])
            rows = cursor.fetchall()
            return [dict(row) for row in rows]

        else:
            raise

def test_assignment(sqlite_db, file_path):
    run_assignment(sqlite_db, file_path)

def run_assignment(sqlite_db, file_path):
    with open("test-results.json", "w") as json_file:
        queries = load_queries(file_path)
        test_result = []
        for parsed_query in queries:
            try:
                rows = run_query(sqlite_db, parsed_query["query"])
                test_result.append({
                    "number": parsed_query["number"],
                    "query": parsed_query["query"],
                    "result": rows[0:3],
                    "error": None
                })
            except Exception as e:
                test_result.append({
                    "number": parsed_query["number"],
                    "query": parsed_query["query"],
                    "result": [],
                    "error": str(e)
                })
        json.dump(test_result, json_file, indent=2)

    # The purpose of it to have report in the future in case DSI will want to go with unit testing style.
    # assert True, "test execution query {} result {}".format(queries, test_result)

