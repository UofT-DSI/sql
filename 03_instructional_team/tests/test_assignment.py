import json
from datetime import datetime, timedelta, timezone
import time
import re
import sqlite3
from collections import Counter
from pathlib import Path


PRODUCT_COLUMNS = (
    "product_id", "product_name", "product_size",
    "product_category_id", "product_qty_type",
)


def load_queries(sql_file):
    """Extract exactly one closed answer block per required question."""
    queries = {}
    number = None
    buffer = []
    for line in Path(sql_file).read_text().splitlines():
        stripped = line.strip()
        start = re.fullmatch(r"--\s*QUERY\s+(\d+)\s*", stripped, re.I)
        end = re.fullmatch(r"--\s*END\s+QUERY\s*", stripped, re.I)
        if start:
            if number is not None:
                raise ValueError("An answer block was not closed before the next QUERY marker.")
            number = int(start[1])
            if number not in range(1, 13) or number in queries:
                raise ValueError(f"Unknown or duplicate QUERY number: {number}.")
            buffer = []
        elif end:
            if number is None:
                raise ValueError("END QUERY has no matching QUERY marker.")
            queries[number] = "\n".join(buffer).strip()
            number = None
        elif re.match(r"--\s*(QUERY|END\s+QUERY)\b", stripped, re.I):
            raise ValueError(f"Invalid answer marker: {stripped}")
        elif number is not None:
            buffer.append(line)
    if number is not None:
        raise ValueError(f"QUERY {number} has no END QUERY marker.")
    return [{"number": n, "query": queries.get(n, "")} for n in range(1, 13)]


def sql_tokens(query):
    """Return unquoted SQL tokens, excluding comments and string literals."""
    pattern = r"--[^\n]*|/\*[\s\S]*?\*/|'(?:''|[^'])*'|\"(?:\"\"|[^\"])*\"|`[^`]*`|\[[^]]*\]|[A-Za-z_][A-Za-z_0-9]*|[^\s]"
    return [part.upper() for part in re.findall(pattern, query)
            if not part.startswith(("--", "/*", "'", '\"', "`", "["))]


def technique_feedback(number, query):
    """Confirm required syntax independently from result correctness."""
    tokens = sql_tokens(query)
    pairs = set(zip(tokens, tokens[1:]))
    requirements = {1: ("COALESCE", "("), 4: ("COUNT", "("),
                    5: ("SUBSTR", "("), 8: ("CROSS", "JOIN"),
                    10: ("INSERT", "INTO"), 11: ("DELETE", "FROM")}
    required = requirements.get(number)
    if required and required not in pairs:
        return f"The required SQL technique ({required[0]}) was not found."
    if number in (2, 3, 4) and ("OVER", "(") not in pairs:
        return "Use a window function for this answer."
    if number == 6 and "REGEXP" not in tokens:
        return "Use REGEXP as requested."
    if number == 7 and "UNION" not in tokens:
        return "Use UNION as requested."
    if number == 12 and "UPDATE" not in tokens:
        return "Use UPDATE as requested."
    return None


def register_functions(conn, clock=None):
    """Add the REGEXP function required by Assignment 2 to SQLite."""
    # Python's SQLite does not include REGEXP by default, but Assignment 2 Question 6 requires it.
    conn.create_function(
        "REGEXP", 2,
        lambda pattern, value: value is not None and re.search(pattern, str(value)) is not None,
    )

    if clock is not None:
        conn.create_function("current_timestamp", 0, lambda: clock[0])
        conn.create_function("current_date", 0, lambda: clock[0].split()[0])
        conn.create_function("current_time", 0, lambda: clock[0].split()[1])
        # Delegate SQLite date semantics while making 'now' deterministic.
        for name in ("date", "time", "datetime", "strftime", "julianday", "unixepoch"):
            def date_function(*args, function=name):
                values = tuple(clock[0] if arg == "now" else arg for arg in args)
                if not values and function != "strftime":
                    values = (clock[0],)
                placeholders = ",".join("?" for _ in values)
                delegate = sqlite3.connect(":memory:")
                try:
                    return delegate.execute(f"SELECT {function}({placeholders})", values).fetchone()[0]
                finally:
                    delegate.close()
            conn.create_function(name, -1, date_function)


def clone_database(source, clock=None):
    """Create an isolated in-memory copy of the course database."""
    clone = sqlite3.connect(":memory:")
    clone.row_factory = sqlite3.Row
    source.backup(clone)
    register_functions(clone, clock)
    clone.set_authorizer(lambda action, *_: sqlite3.SQLITE_DENY
                         if action in (sqlite3.SQLITE_ATTACH, sqlite3.SQLITE_DETACH)
                         else sqlite3.SQLITE_OK)
    return clone


def run_query(conn, query):
    """Execute SQL statements without splitting quoted semicolons or comments."""
    deadline = time.monotonic() + 10
    conn.set_progress_handler(lambda: int(time.monotonic() > deadline), 1000)
    cursor = conn.cursor()
    buffer = ""
    try:
        for character in query:
            buffer += character
            if character == ";" and sqlite3.complete_statement(buffer):
                if any(token != ";" for token in sql_tokens(buffer)):
                    cursor.execute(buffer)
                buffer = ""
        if any(token != ";" for token in sql_tokens(buffer)):
            cursor.execute(buffer)
        return [dict(row) for row in cursor.fetchall()]
    finally:
        conn.set_progress_handler(None, 0)


def fetch(conn, query, parameters=()):
    """Run an internal grading query and return its rows as dictionaries."""
    return [dict(row) for row in conn.execute(query, parameters).fetchall()]


def normalize_value(value):
    """Normalize floating-point values so result comparisons are reliable."""
    return round(value, 6) if isinstance(value, float) else value


def count_result_rows(rows, keys):
    """Count normalized result rows using only the requested columns."""
    return Counter(tuple(normalize_value(row[key]) for key in keys) for row in rows)


def extract_result_rows(rows, columns, last_fallback=False):
    """Extract comparable columns from student results using accepted column names."""
    if not rows:
        return Counter()
    actual_keys = []
    lower_keys = {key.lower(): key for key in rows[0]}
    for index, choices in enumerate(columns):
        key = next((lower_keys[name.lower()] for name in choices if name.lower() in lower_keys), None)
        if key is None and last_fallback and index == len(columns) - 1:
            key = list(rows[0])[-1]
        if key is None:
            return None
        actual_keys.append(key)
    return Counter(tuple(normalize_value(row[key]) for key in actual_keys) for row in rows)


def grading_outcome(passed, success, failure):
    """Return a grading status and the matching feedback message."""
    return ("correct", success) if passed else ("incorrect", failure)


def grade_question_1(rows, reference):
    """Grade the COALESCE product-description answer."""
    expected = fetch(reference, """
        SELECT product_name || ', ' || COALESCE(product_size, '') ||
               ' (' || COALESCE(product_qty_type, 'unit') || ')' AS value
        FROM product
    """)
    # Each expected row contains one complete product description.
    expected_descriptions = []
    for row in expected:
        expected_descriptions.append(row["value"])

    # The student must also return one description column per row.
    has_one_column_per_row = bool(rows)
    for row in rows:
        if len(row) != 1:
            has_one_column_per_row = False
            break

    actual_descriptions = None
    if has_one_column_per_row:
        actual_descriptions = []
        for row in rows:
            values = list(row.values())
            description = values[0]
            actual_descriptions.append(normalize_value(description))

    # Count descriptions so duplicates matter, while row order does not.
    answers_match = False
    if actual_descriptions is not None:
        actual_counts = Counter(actual_descriptions)
        expected_counts = Counter(expected_descriptions)
        answers_match = actual_counts == expected_counts

    return grading_outcome(
        answers_match,
        "All product descriptions and NULL replacements are correct.",
        "The formatted product descriptions do not match the expected results.",
    )


def grade_question_2(rows, reference):
    """Grade the ascending customer visit-number answer."""
    actual = extract_result_rows(
        rows, (("customer_id",), ("market_date",), ("visit_number",)), True
    )
    full = fetch(reference, """
        SELECT customer_id, market_date,
               DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
        FROM customer_purchases WHERE market_date < '2022-04-29'
    """)
    unique = fetch(reference, """
        SELECT customer_id, market_date,
               ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
        FROM (SELECT DISTINCT customer_id, market_date FROM customer_purchases
              WHERE market_date < '2022-04-29')
    """)
    keys = ("customer_id", "market_date", "visit_number")
    accepted = [count_result_rows(result, keys) for result in (full, unique)]
    return grading_outcome(
        actual in accepted,
        "Visit dates are numbered correctly for each customer.",
        "The visit numbers or returned dates are incorrect.",
    )


def grade_question_3(rows, reference):
    """Grade the most-recent customer visit answer."""
    actual = extract_result_rows(
        rows, (("customer_id",), ("market_date",), ("visit_number",)), True
    )
    full = fetch(reference, """
        SELECT customer_id, market_date, 1 AS visit_number
        FROM customer_purchases AS p
        WHERE market_date = (SELECT MAX(market_date) FROM customer_purchases
                             WHERE customer_id = p.customer_id)
    """)
    unique = fetch(reference, """
        SELECT customer_id, MAX(market_date) AS market_date, 1 AS visit_number
        FROM customer_purchases GROUP BY customer_id
    """)
    keys = ("customer_id", "market_date", "visit_number")
    accepted = [count_result_rows(result, keys) for result in (full, unique)]
    return grading_outcome(
        actual in accepted,
        "Only each customer's most recent visit is returned.",
        "The result does not contain only each customer's most recent visit.",
    )


def grade_question_4(rows, reference):
    """Grade the customer product-purchase count answer."""
    columns = (
        ("customer_id",), ("vendor_id",), ("product_id",),
        ("market_date",), ("transaction_time",), ("product_purchase_count",),
    )
    actual = extract_result_rows(rows, columns, True)
    fixed = fetch(reference, """
        SELECT customer_id, vendor_id, product_id, market_date, transaction_time,
               COUNT(*) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count
        FROM customer_purchases WHERE market_date < '2022-04-29'
    """)
    running = fetch(reference, """
        SELECT customer_id, vendor_id, product_id, market_date, transaction_time,
               COUNT(*) OVER (PARTITION BY customer_id, product_id
                              ORDER BY market_date, transaction_time
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS product_purchase_count
        FROM customer_purchases WHERE market_date < '2022-04-29'
    """)
    keys = tuple(item[0] for item in columns)
    accepted = [count_result_rows(result, keys) for result in (fixed, running)]
    return grading_outcome(
        actual in accepted,
        "The purchase count is correct for every customer and product.",
        "The purchase counts or returned rows are incorrect.",
    )


def grade_question_5(rows, reference):
    """Grade the product-name description extraction answer."""
    expected = fetch(reference, """
        SELECT product_name,
               CASE WHEN INSTR(product_name, '-') > 0
                    THEN TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1))
                    ELSE NULL END AS description
        FROM product
    """)
    expected_rows = count_result_rows(expected, ("product_name", "description"))
    # Students may name the description column differently; compare its values with each product.
    matches = any(
        extract_result_rows(rows, (("product_name",), (column,))) == expected_rows
        for column in (rows[0] if rows else ())
        if column.lower() != "product_name"
    )
    return grading_outcome(
        matches,
        "Product descriptions are extracted and trimmed correctly.",
        "The descriptions do not match the text after each product-name hyphen.",
    )


def grade_question_6(rows, reference):
    """Grade the numeric product-size REGEXP answer."""
    actual = extract_result_rows(rows, (("product_size",),))
    if actual is None and rows and all(len(row) == 1 for row in rows):
        actual = Counter((normalize_value(next(iter(row.values()))),) for row in rows)
    expected = fetch(
        reference, "SELECT product_size FROM product WHERE product_size REGEXP '[0-9]'"
    )
    return grading_outcome(
        actual == count_result_rows(expected, ("product_size",)),
        "Only product sizes containing a number are returned.",
        "The result does not match all product sizes containing a number.",
    )


def grade_question_7(rows, reference):
    """Grade the highest and lowest market-sales answer."""
    actual = extract_result_rows(rows, (("market_date",), ("sales", "total_sales", "revenue")), True)
    expected = fetch(reference, """
        WITH daily AS (
            SELECT market_date, ROUND(SUM(quantity * cost_per_quantity), 2) AS sales
            FROM customer_purchases GROUP BY market_date
        )
        SELECT market_date, sales FROM daily
        WHERE sales = (SELECT MIN(sales) FROM daily)
           OR sales = (SELECT MAX(sales) FROM daily)
    """)
    if rows and all(len(row) == 1 for row in rows):
        actual_dates = Counter(next(iter(row.values())) for row in rows)
        return grading_outcome(actual_dates == Counter(row["market_date"] for row in expected),
                               "The highest and lowest sales dates are correct.",
                               "The highest and lowest sales dates are incorrect.")
    if actual != count_result_rows(expected, ("market_date", "sales")) and rows:
        for column in rows[0]:
            if column == "market_date":
                continue
            candidate = extract_result_rows(rows, (("market_date",), (column,)))
            if candidate == count_result_rows(expected, ("market_date", "sales")):
                actual = candidate
                break
    return grading_outcome(
        actual == count_result_rows(expected, ("market_date", "sales")),
        "The highest and lowest sales dates and totals are correct.",
        "The result does not match the highest and lowest sales dates.",
    )


def grade_question_8(rows, reference):
    """Grade the possible vendor revenue answer."""
    actual = extract_result_rows(
        rows,
        (("vendor_name",), ("product_name",), ("possible_revenue", "sum(price)", "revenue")),
        True,
    )
    expected = fetch(reference, """
        SELECT vendor_name, product_name, SUM(price) AS possible_revenue
        FROM (
            SELECT DISTINCT vendor_name, product_name, 5 * original_price AS price
            FROM vendor_inventory JOIN vendor USING (vendor_id) JOIN product USING (product_id)
        )
        CROSS JOIN (SELECT DISTINCT customer_id FROM customer)
        GROUP BY vendor_name, product_name
    """)
    return grading_outcome(
        actual == count_result_rows(expected, ("vendor_name", "product_name", "possible_revenue")),
        "Possible revenue is correct for every vendor and product.",
        "The possible revenue does not match five items per customer.",
    )


SELECT_GRADERS = {
    1: grade_question_1,
    2: grade_question_2,
    3: grade_question_3,
    4: grade_question_4,
    5: grade_question_5,
    6: grade_question_6,
    7: grade_question_7,
    8: grade_question_8,
}


def grade_select(number, rows, reference):
    """Dispatch Questions 1 through 8 to their grading functions."""
    grader = SELECT_GRADERS.get(number)
    if grader is None:
        return "incorrect", "This query number is not part of Assignment 2."
    return grader(rows, reference)


def product_units_state(conn):
    """Return the product_units table structure and data when the table exists."""
    exists = conn.execute(
        "SELECT 1 FROM sqlite_master WHERE type='table' AND name='product_units'"
    ).fetchone()
    if not exists:
        return None
    columns = [row["name"] for row in fetch(conn, "PRAGMA table_info(product_units)")]
    rows = fetch(conn, "SELECT * FROM product_units")
    try:
        identities = fetch(conn, "SELECT rowid AS identity FROM product_units")
        rowids = [row["identity"] for row in identities]
    except sqlite3.OperationalError:
        rowids = None
    return {"columns": columns, "rows": rows, "rowids": rowids}


def count_table_rows(rows, columns):
    """Convert selected row values into a countable form for state comparisons."""
    return Counter(
        tuple(normalize_value(row[column]) for column in columns)
        for row in rows
    )


def timestamp_value(value):
    timestamp = datetime.fromisoformat(str(value).replace("Z", "+00:00"))
    if timestamp.tzinfo is not None:
        timestamp = timestamp.astimezone(timezone.utc).replace(tzinfo=None)
    return timestamp


def valid_timestamp(value, context):
    try:
        return abs((timestamp_value(value) - timestamp_value(context["execution_time"])).total_seconds()) <= 5
    except (ValueError, TypeError):
        return False


def grade_question_9(conn, reference, context, before):
    state = product_units_state(conn)
    required = set(PRODUCT_COLUMNS) | {"snapshot_timestamp"}
    expected = fetch(reference, "SELECT * FROM product WHERE product_qty_type='unit'")
    passed = (state is not None and set(state["columns"]) == required
              and count_table_rows(state["rows"], PRODUCT_COLUMNS) == count_table_rows(expected, PRODUCT_COLUMNS)
              and all(valid_timestamp(row["snapshot_timestamp"], context) for row in state["rows"]))
    return grading_outcome(passed, "Unit products and current snapshot timestamps are correct.",
                           "Check the columns, unit products, and current snapshot timestamps.")


def grade_question_10(conn, reference, context, before):
    state = product_units_state(conn)
    if before is None or state is None or set(state["columns"]) != set(before["columns"]):
        return "incorrect", "The product_units schema changed or is missing."
    columns = before["columns"]
    old = count_table_rows(before["rows"], columns)
    new = count_table_rows(state["rows"], columns)
    added = new - old
    if old - new or sum(added.values()) != 1:
        return "incorrect", "Insert exactly one row without changing existing rows."
    row = dict(zip(columns, next(iter(added))))
    passed = (row["product_id"] is not None and row["product_category_id"] is not None
              and isinstance(row["product_name"], str) and bool(row["product_name"].strip())
              and isinstance(row["product_qty_type"], str) and bool(row["product_qty_type"].strip())
              and valid_timestamp(row["snapshot_timestamp"], context))
    if passed:
        previous_copies = [existing for existing in before["rows"]
                           if existing["product_id"] == row["product_id"]]
        passed = all(timestamp_value(row["snapshot_timestamp"]) >= timestamp_value(existing["snapshot_timestamp"])
                     for existing in previous_copies)
    # Save the inserted row for Q11 so we can check that it survives the deletion.
    if passed:
        context["inserted_row"] = row
        if before["rowids"] is not None and state["rowids"] is not None:
            added_ids = set(state["rowids"]) - set(before["rowids"])
            if len(added_ids) == 1:
                context["inserted_rowid"] = added_ids.pop()
    return grading_outcome(passed, "One product with a current timestamp was inserted.",
                           "Check the inserted product fields and updated timestamp.")


def grade_question_11(conn, reference, context, before):
    state = product_units_state(conn)
    inserted = context.get("inserted_row")
    if before is None or state is None or inserted is None:
        return "blocked", "A valid preceding insertion is needed to assess the deletion."
    columns = before["columns"]
    if set(columns) != set(state["columns"]):
        return "incorrect", "Deleting a record must preserve the table schema."
    before_rows = count_table_rows(before["rows"], columns)
    after_rows = count_table_rows(state["rows"], columns)
    inserted_key = tuple(normalize_value(inserted[column]) for column in columns)
    candidates = before_rows.copy()
    candidates.subtract({inserted_key: 1})
    old_rows = [dict(zip(columns, key)) for key, count in candidates.items()
                if count > 0 and key[columns.index("product_id")] == inserted["product_id"]]
    if not old_rows:
        return "manual_review", "The inserted product has no older copy; the deletion needs instructor review."
    removed = before_rows - after_rows
    if after_rows - before_rows or sum(removed.values()) != 1:
        return "incorrect", "Remove exactly the older copy and retain the newer copy and other rows."
    oldest = min(timestamp_value(row["snapshot_timestamp"]) for row in old_rows)
    removed_row = dict(zip(columns, next(iter(removed))))
    passed = (removed_row["product_id"] == inserted["product_id"]
              and timestamp_value(removed_row["snapshot_timestamp"]) == oldest
              and after_rows[inserted_key] >= 1)
    if context.get("inserted_rowid") is not None and state["rowids"] is not None:
        passed = passed and context["inserted_rowid"] in state["rowids"]
    return grading_outcome(passed, "Only the older copy was removed; the inserted copy remains.",
                           "Retain the inserted copy and remove only the older copy.")


def grade_question_12(conn, reference, context, before):
    state = product_units_state(conn)
    if before is None or state is None or set(state["columns"]) != set(before["columns"]) | {"current_quantity"}:
        return "incorrect", "Add current_quantity while preserving the existing table columns."
    if count_table_rows(before["rows"], before["columns"]) != count_table_rows(state["rows"], before["columns"]):
        return "incorrect", "UPDATE must preserve all existing rows and non-quantity values."
    for row in state["rows"]:
        latest = fetch(reference, """
            SELECT COALESCE(quantity, 0) AS quantity FROM vendor_inventory
            WHERE product_id=? AND market_date=(
                SELECT MAX(market_date) FROM vendor_inventory WHERE product_id=?)
        """, (row["product_id"], row["product_id"]))
        allowed = {normalize_value(item["quantity"]) for item in latest} or {0}
        if normalize_value(row["current_quantity"]) not in allowed:
            return "incorrect", f"Product {row['product_id']} does not have its latest quantity."
    return "correct", "All rows remain and current_quantity matches the latest inventory."


MUTATION_GRADERS = {
    9: grade_question_9,
    10: grade_question_10,
    11: grade_question_11,
    12: grade_question_12,
}


def grade_mutation(number, conn, reference, context, before):
    """Dispatch Questions 9 through 12 to their grading functions."""
    grader = MUTATION_GRADERS.get(number)
    if grader is None:
        return "incorrect", "This query number is not part of Assignment 2."
    return grader(conn, reference, context, before)


def build_result(number, query, status, feedback, rows=None, error=None):
    """Build one consistently shaped entry for the JSON grading report."""
    return {
        "number": number,
        "query": query,
        "status": status,
        "feedback": feedback,
        "result": (rows or [])[:3],
        "error": str(error) if error is not None else None,
    }


def test_assignment(sqlite_db, file_path, report_path):
    """Provide the pytest entry point for grading the submitted assignment file."""
    run_assignment(sqlite_db, file_path, report_path)


def run_assignment(sqlite_db, file_path, report_path="test-results.json"):
    """Write complete feedback, including malformed submissions and dependencies."""
    results = []
    reference = mutations = None
    # Real grading can give Q9 and Q10 the same timestamp, so we control the clock and deliberately advance it.
    clock = [datetime.now(timezone.utc).replace(tzinfo=None, microsecond=0).isoformat(" ")]
    start = datetime.fromisoformat(clock[0])
    context = {}
    statuses = {}
    try:
        if Path(file_path).name.lower() != "assignment2.sql":
            raise ValueError("This grader only supports Assignment 2.")
        answers = load_queries(file_path)
        reference = clone_database(sqlite_db)
        mutations = clone_database(sqlite_db, clock)
        for parsed in answers:
            number, query = parsed["number"], parsed["query"]
            rows, error = [], None
            conn = None
            try:
                if not sql_tokens(query):
                    status, feedback = "missing", "No SQL answer was submitted."
                elif number >= 10 and statuses.get(9) != "correct":
                    status, feedback = "blocked", "Question 9 must create a valid snapshot first."
                elif number == 11 and statuses.get(10) != "correct":
                    status, feedback = "blocked", "Question 10 must insert a valid product first."
                elif number == 12 and statuses.get(11) not in ("correct", "manual_review"):
                    status, feedback = "blocked", "Question 11 must preserve the intended product rows first."
                else:
                    # Q9 starts at zero; each later mutation advances one second so older rows are identifiable.
                    clock[0] = (start + timedelta(seconds=max(0, number - 9))).isoformat(" ")
                    context["execution_time"] = clock[0]
                    conn = clone_database(sqlite_db, clock) if number < 9 else mutations
                    before = product_units_state(conn) if number >= 10 else None
                    rows = run_query(conn, query)
                    if number < 9:
                        status, feedback = grade_select(number, rows, reference)
                    else:
                        status, feedback = grade_mutation(number, conn, reference, context, before)
                    technique = technique_feedback(number, query)
                    if status == "correct" and technique:
                        status, feedback = "incorrect", technique
            except Exception as exception:
                status, feedback, error = "error", "The SQL could not be executed or assessed.", exception
            finally:
                if conn is not None and number < 9:
                    conn.close()
            statuses[number] = status
            results.append(build_result(number, query, status, feedback, rows, error))
    except Exception as exception:
        results = [build_result(n, "", "error", "Submission could not be parsed or loaded.", error=exception)
                   for n in range(1, 13)]
    finally:
        if reference is not None:
            reference.close()
        if mutations is not None:
            mutations.close()
        Path(report_path).write_text(json.dumps(results, indent=2))
    return results
