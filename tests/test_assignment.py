import json
import re
import sqlite3
from collections import Counter
from pathlib import Path


PRODUCT_COLUMNS = (
    "product_id", "product_name", "product_size",
    "product_category_id", "product_qty_type",
)


def load_queries(sql_file):
    queries = []
    number = None
    buffer = []
    for line in Path(sql_file).read_text().splitlines():
        stripped = line.strip()
        if stripped.lower().startswith("--query"):
            if number is not None:
                raise AssertionError("Nested QUERY blocks are not allowed")
            try:
                number = int(stripped.split()[1])
            except (IndexError, ValueError) as error:
                raise AssertionError(f"Invalid QUERY marker: {line}") from error
            buffer = []
        elif stripped.lower().startswith("--end") and number is not None:
            queries.append({"number": number, "query": "\n".join(buffer).strip().rstrip(";")})
            number = None
            buffer = []
        elif number is not None:
            buffer.append(line)
    if not queries:
        raise AssertionError("No queries found. Use '-- QUERY <n>' and '-- END QUERY' markers.")
    return queries


def register_functions(conn):
    conn.create_function(
        "REGEXP", 2,
        lambda pattern, value: value is not None and re.search(pattern, str(value)) is not None,
    )


def clone_database(source):
    clone = sqlite3.connect(":memory:")
    clone.row_factory = sqlite3.Row
    source.backup(clone)
    register_functions(clone)
    return clone


def run_query(conn, query):
    cursor = conn.cursor()
    try:
        cursor.execute(query)
    except sqlite3.ProgrammingError as error:
        if "one statement at a time" not in str(error).lower():
            raise
        statements = [statement.strip() for statement in query.split(";") if statement.strip()]
        if not statements:
            return []
        for statement in statements:
            cursor.execute(statement)
    return [dict(row) for row in cursor.fetchall()]


def fetch(conn, query, parameters=()):
    return [dict(row) for row in conn.execute(query, parameters).fetchall()]


def normal(value):
    return round(value, 6) if isinstance(value, float) else value


def counter(rows, keys):
    return Counter(tuple(normal(row[key]) for key in keys) for row in rows)


def extract(rows, columns, last_fallback=False):
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
    return Counter(tuple(normal(row[key]) for key in actual_keys) for row in rows)


def outcome(passed, success, failure):
    return ("correct", success) if passed else ("incorrect", failure)


def grade_select(number, rows, reference):
    if number == 1:
        expected = fetch(reference, """
            SELECT product_name || ', ' || COALESCE(product_size, '') ||
                   ' (' || COALESCE(product_qty_type, 'unit') || ')' AS value
            FROM product
        """)
        actual = Counter(normal(next(iter(row.values()))) for row in rows) if rows and all(len(row) == 1 for row in rows) else None
        return outcome(
            actual == Counter(row["value"] for row in expected),
            "All product descriptions and NULL replacements are correct.",
            "The formatted product descriptions do not match the expected results.",
        )

    if number == 2:
        actual = extract(rows, (("customer_id",), ("market_date",), ("visit_number",)), True)
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
        expected = [counter(item, ("customer_id", "market_date", "visit_number")) for item in (full, unique)]
        return outcome(
            actual in expected,
            "Visit dates are numbered correctly for each customer.",
            "The visit numbers or the April 29 date filter are incorrect.",
        )

    if number == 3:
        actual = extract(rows, (("customer_id",), ("market_date",), ("visit_number",)), True)
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
        expected = [counter(item, ("customer_id", "market_date", "visit_number")) for item in (full, unique)]
        return outcome(
            actual in expected,
            "Only each customer's most recent visit is returned.",
            "The result does not contain only each customer's most recent visit.",
        )

    if number == 4:
        columns = (
            ("customer_id",), ("vendor_id",), ("product_id",),
            ("market_date",), ("transaction_time",), ("product_purchase_count",),
        )
        actual = extract(rows, columns, True)
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
        return outcome(
            actual in [counter(item, keys) for item in (fixed, running)],
            "The purchase count is correct for every customer and product.",
            "The purchase counts, rows, or date filter are incorrect.",
        )

    if number == 5:
        actual = extract(rows, (("product_name",), ("description",)))
        expected = fetch(reference, """
            SELECT product_name,
                   CASE WHEN INSTR(product_name, '-') > 0
                        THEN TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1))
                        ELSE NULL END AS description
            FROM product
        """)
        return outcome(
            actual == counter(expected, ("product_name", "description")),
            "Product descriptions are extracted and trimmed correctly.",
            "The descriptions do not match the text after each product-name hyphen.",
        )

    if number == 6:
        actual = extract(rows, (("product_size",),))
        if actual is None and rows and all(len(row) == 1 for row in rows):
            actual = Counter((normal(next(iter(row.values()))),) for row in rows)
        expected = fetch(reference, "SELECT product_size FROM product WHERE product_size REGEXP '[0-9]'")
        return outcome(
            actual == counter(expected, ("product_size",)),
            "Only product sizes containing a number are returned.",
            "The result does not match all product sizes containing a number.",
        )

    if number == 7:
        actual = extract(rows, (("market_date",), ("sales", "total_sales")))
        expected = fetch(reference, """
            WITH daily AS (
                SELECT market_date, ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS sales
                FROM customer_purchases GROUP BY market_date
            )
            SELECT market_date, sales FROM daily
            WHERE sales = (SELECT MIN(sales) FROM daily)
               OR sales = (SELECT MAX(sales) FROM daily)
        """)
        return outcome(
            actual == counter(expected, ("market_date", "sales")),
            "The highest and lowest sales dates and totals are correct.",
            "The result does not match the highest and lowest sales dates.",
        )

    if number == 8:
        actual = extract(rows, (("vendor_name",), ("product_name",), ("possible_revenue", "sum(price)", "revenue")), True)
        expected = fetch(reference, """
            SELECT vendor_name, product_name, SUM(price) AS possible_revenue
            FROM (
                SELECT DISTINCT vendor_name, product_name, 5 * original_price AS price
                FROM vendor_inventory JOIN vendor USING (vendor_id) JOIN product USING (product_id)
            )
            CROSS JOIN (SELECT DISTINCT customer_id FROM customer)
            GROUP BY vendor_name, product_name
        """)
        return outcome(
            actual == counter(expected, ("vendor_name", "product_name", "possible_revenue")),
            "Possible revenue is correct for every vendor and product.",
            "The possible revenue does not match five items per customer.",
        )

    return "incorrect", "This query number is not part of Assignment 2."


def product_units_state(conn):
    exists = conn.execute(
        "SELECT 1 FROM sqlite_master WHERE type='table' AND name='product_units'"
    ).fetchone()
    if not exists:
        return None
    columns = [row["name"] for row in fetch(conn, "PRAGMA table_info(product_units)")]
    return {"columns": columns, "rows": fetch(conn, "SELECT * FROM product_units")}


def tuple_rows(rows, columns):
    return Counter(tuple(normal(row[column]) for column in columns) for row in rows)


def grade_mutation(number, conn, reference, context, before):
    state = product_units_state(conn)
    if number == 9:
        required = list(PRODUCT_COLUMNS) + ["snapshot_timestamp"]
        expected = fetch(reference, "SELECT * FROM product WHERE product_qty_type='unit'")
        passed = (
            state is not None
            and state["columns"] == required
            and tuple_rows(state["rows"], PRODUCT_COLUMNS) == tuple_rows(expected, PRODUCT_COLUMNS)
            and all(row["snapshot_timestamp"] is not None for row in state["rows"])
        )
        return outcome(
            passed,
            "product_units has the right columns, unit products, and timestamps.",
            "product_units is missing, has wrong columns, or contains the wrong products.",
        )

    if number == 10:
        if before is None or state is None or len(state["rows"]) != len(before["rows"]) + 1:
            return "incorrect", "Exactly one new row was not added to product_units."
        added = tuple_rows(state["rows"], state["columns"]) - tuple_rows(before["rows"], state["columns"])
        if sum(added.values()) != 1:
            return "incorrect", "The grader could not identify one newly inserted row."
        row = dict(zip(state["columns"], next(iter(added))))
        source = fetch(
            reference,
            "SELECT * FROM product WHERE product_id=? AND product_category_id=?",
            (row["product_id"], row["product_category_id"]),
        )
        passed = bool(source) and all(row[key] == normal(source[0][key]) for key in PRODUCT_COLUMNS)
        passed = passed and row["snapshot_timestamp"] is not None
        if passed:
            context["inserted_product_id"] = row["product_id"]
        return outcome(
            passed,
            "Exactly one valid product row with a timestamp was inserted.",
            "The inserted row does not match a product or is missing its timestamp.",
        )

    if number == 11:
        product_id = context.get("inserted_product_id")
        if before is None or state is None or product_id is None:
            return "incorrect", "The previously inserted product could not be checked."
        columns = state["columns"]
        before_other = [row for row in before["rows"] if row["product_id"] != product_id]
        after_other = [row for row in state["rows"] if row["product_id"] != product_id]
        before_product = [row for row in before["rows"] if row["product_id"] == product_id]
        after_product = [row for row in state["rows"] if row["product_id"] == product_id]
        oldest = min(row["snapshot_timestamp"] for row in before_product)
        passed = tuple_rows(before_other, columns) == tuple_rows(after_other, columns)
        passed = passed and len(after_product) < len(before_product)
        passed = passed and all(row["snapshot_timestamp"] != oldest for row in after_product)
        return outcome(
            passed,
            "The oldest copy was removed without affecting other products.",
            "The older copy remains, or unrelated product rows were deleted.",
        )

    if number == 12:
        if state is None or "current_quantity" not in state["columns"]:
            return "incorrect", "The current_quantity column was not added."
        for row in state["rows"]:
            latest = fetch(reference, """
                SELECT COALESCE(quantity, 0) AS quantity FROM vendor_inventory
                WHERE product_id=? AND market_date=(
                    SELECT MAX(market_date) FROM vendor_inventory WHERE product_id=?
                )
            """, (row["product_id"], row["product_id"]))
            allowed = {normal(item["quantity"]) for item in latest} or {0}
            if normal(row["current_quantity"]) not in allowed:
                return "incorrect", f"Product {row['product_id']} does not have its latest quantity."
        return "correct", "current_quantity matches the latest inventory for every product."

    return "incorrect", "This query number is not part of Assignment 2."


def test_assignment(sqlite_db, file_path):
    run_assignment(sqlite_db, file_path)


def run_assignment(sqlite_db, file_path):
    assignment_2 = Path(file_path).name.lower() == "assignment2.sql"
    reference = clone_database(sqlite_db)
    mutations = clone_database(sqlite_db)
    fallback = clone_database(sqlite_db)
    context = {}
    results = []
    try:
        for parsed in load_queries(file_path):
            number = parsed["number"]
            if assignment_2 and number < 9:
                conn = clone_database(sqlite_db)
            elif assignment_2:
                conn = mutations
            else:
                conn = fallback
            before = product_units_state(conn) if assignment_2 and number >= 10 else None
            try:
                rows = run_query(conn, parsed["query"])
                if assignment_2 and number < 9:
                    status, feedback = grade_select(number, rows, reference)
                elif assignment_2:
                    status, feedback = grade_mutation(number, conn, reference, context, before)
                else:
                    status, feedback = "executed", "The query ran without a SQL error."
                results.append({
                    "number": number, "query": parsed["query"], "status": status,
                    "feedback": feedback, "result": rows[:3], "error": None,
                })
            except Exception as error:
                results.append({
                    "number": number, "query": parsed["query"], "status": "error",
                    "feedback": "The SQL did not run.", "result": [], "error": str(error),
                })
            finally:
                if assignment_2 and number < 9:
                    conn.close()
    finally:
        reference.close()
        mutations.close()
        fallback.close()
    Path("test-results.json").write_text(json.dumps(results, indent=2))
