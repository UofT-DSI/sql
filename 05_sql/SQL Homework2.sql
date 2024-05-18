--SELECT
--1. return everything in customer table
SELECT*FROM customer

--2. display all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name
SELECT*FROM customer WHERE ROWID <11
ORDER BY customer_last_name ASC, customer_first_name ASC



--WHERE
--1. query that returns all customer purchases of product IDs 4 and 9
--(NOTE: not sure why I get "Execution finished without errors" but no output when I add "AND product_id = 9" to the SQL query below)
SELECT*FROM customer_purchases WHERE product_id =4 AND  product_id = 9

--2. query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using "BETWEEN"
-- (NOTE: commands run ok in 2 separate runs, not sure why it results in an error when run together)
ALTER TABLE customer_purchases ADD  [price] AS (quantity * cost_to_customer_per_qty)
SELECT * FROM customer_purchases WHERE vendor_id BETWEEN 8 AND 10 



--CASE
--1. query that outputs the product_id and product_name columns and add a column called prod_qty_type_condensed that displays the word “unit” if the product_qty_type is “unit,” and otherwise displays the word “bulk.”
--(NOTE: when run, results in error that says 'unit' is not a column name. tried [ and no syntax (bracket or quotation) but still results in same error. Attempted to run code with an acutal column name from table replacing "unit" but output still says column name not found.
SELECT product_id, product_name 
,CASE WHEN product_qty_type = 'unit' THEN ['unit']
ELSE 'bulk' END as prod_qty_type_condensed
FROM product

--2. Add a column to the previous query called pepper_flag that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.
-- (NOTE: see note above)
SELECT product_id, product_name 
,CASE WHEN product_qty_type = 'unit' THEN ['unit']
ELSE 'bulk' END as prod_qty_type_condensed
,CASE WHEN product_name = 'pepper' THEN ['1']
ELSE '0' END as pepper_flag
FROM product



--JOIN
--1. query that INNER JOINs the vendor table to the vendor_booth_assignments table on the vendor_id field they both have in common, and sorts the result by vendor_name, then market_date.

SELECT * FROM vendor v
JOIN vendor_booth_assignments vba
ON v.vendor_id = vba.vendor_id
ORDER by vendor_name ASC, market_date ASC
