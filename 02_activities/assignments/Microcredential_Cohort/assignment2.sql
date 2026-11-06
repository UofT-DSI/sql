/* ASSIGNMENT 2 */
--Please write responses between the QUERY # and END QUERY blocks
/* SECTION 2 */

-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product


But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first column with
nulls, and 'unit' for the second column with nulls. 

**HINT**: keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. 
Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. 
All the other rows will remain the same. */
--QUERY 1

SELECT
coalesce(product_name, '') || ', ' ||
product_size || ' (' ||
coalesce(product_qty_type, 'unit') || ')'
FROM product;

--This fix still provides a NULL result for 13 and would have to be expanded to return zero NULLS

--END QUERY


--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). 
Filter the visits to dates before April 29, 2022. */
--QUERY 2

SELECT 
customer_id,
market_date,
DENSE_RANK() OVER (
PARTITION BY customer_id
ORDER BY market_date
) AS visit_number
FROM customer_purchases
WHERE market_date < '2022-04-29'
ORDER BY customer_id, market_date;



--END QUERY


/* 2. Reverse the numbering of the query so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit.
HINT: Do not use the previous visit dates filter. */
--QUERY 3

SELECT *
FROM (
SELECT DISTINCT
customer_id,
market_date,
DENSE_RANK() OVER (
PARTITION BY customer_id
ORDER BY market_date DESC
) AS visit_number
FROM customer_purchases
) AS recent_visits
WHERE visit_number = 1
ORDER BY customer_id;

--END QUERY


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. 

You can make this a running count by including an ORDER BY in the window function if desired.
Filter the visits to dates before April 29, 2022. */
--QUERY 4

SELECT
*,
COUNT(*) OVER (
PARTITION BY customer_id, product_id) 
AS product_purchase_count
FROM customer_purchases
WHERE market_date < '2022-04-29';


--END QUERY


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */
--QUERY 5

SELECT
product_name,
CASE
WHEN INSTR(product_name, "-") > 0
THEN TRIM (SUBSTR(product_name, INSTR(product_name, '-') +1))
ELSE NULL
END AS description
FROM product;

--+1 to define position

--END QUERY


/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
--QUERY 6

SELECT *
FROM product
WHERE product_size REGEXP '[0-9]';

--END QUERY


-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */
--QUERY 7

DROP TABLE IF EXISTS ranked_sales;
DROP TABLE IF EXISTS daily_sales;

CREATE TEMP TABLE daily_sales AS
SELECT
market_date,
SUM(quantity * cost_per_quantity) AS total_sales
FROM customer_purchases
GROUP BY market_date;

CREATE TEMP TABLE ranked_sales AS
SELECT
market_date,
total_sales,
RANK() OVER (
ORDER BY total_sales DESC
) AS sales_rank,
RANK() OVER (
ORDER BY total_sales ASC
) AS reverse_rank
FROM daily_sales;

SELECT
market_date,
total_sales
FROM ranked_sales
WHERE sales_rank = 1

UNION

SELECT
market_date,
total_sales
FROM ranked_sales
WHERE reverse_rank = 1;

--END QUERY



/* SECTION 3 */

-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */
--QUERY 8

--QUERY 8

SELECT
v.vendor_name,
p.product_name,
SUM(5 * vi.original_price) AS total_sales
FROM (
SELECT DISTINCT
vendor_id,
product_id,
original_price
FROM vendor_inventory
) AS vi
JOIN vendor AS v
ON vi.vendor_id = v.vendor_id
JOIN product AS p
ON vi.product_id = p.product_id
CROSS JOIN customer AS c
GROUP BY
v.vendor_name,
p.product_name
ORDER BY
v.vendor_name,
p.product_name;

--END QUERY


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
--QUERY 9

DROP TABLE IF EXISTS product_units;

CREATE TABLE product_units AS
SELECT 
product_id, 
product_name, 
product_size, 
product_category_id, 
product_qty_type,
CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product 
WHERE product_qty_type = 'unit';

--Checking the table because I couldn't see it
SELECT *
FROM product_units;

--END QUERY


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
--QUERY 10

INSERT INTO product_units
VALUES (24, 'Cut Roses Bouquet', 'medium', 5, 'unit', CURRENT_TIMESTAMP);

--Checking the table because I couldn't see it
SELECT *
FROM product_units;

SELECT *
FROM product_units
WHERE product_id = 24;

--This is where I realized that I took the instructions wrong ughhhh
DELETE FROM product_units
WHERE product_id = 24;

SELECT *
FROM product_units
WHERE product_id = 24;

INSERT INTO product_units
VALUES (6, 'Cut Zinnias Bouquet', 'medium', 5, 'unit', CURRENT_TIMESTAMP);

SELECT *
FROM product_units
WHERE product_id = 6;

--Checking why they have the same timestamp
SELECT
    product_id,
    product_name,
    snapshot_timestamp
FROM product_units
WHERE product_name = 'Cut Zinnias Bouquet';

SELECT
    rowid,
    product_id,
    product_name,
    snapshot_timestamp
FROM product_units
WHERE product_name = 'Cut Zinnias Bouquet';
--Finally

--END QUERY


-- DELETE
/* 1. Delete the older record for whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
--QUERY 11

DELETE FROM product_units
WHERE product_id = 6
AND snapshot_timestamp = '2026-11-06 18:42:18';

--Checking
SELECT
    rowid,
    product_id,
    product_name,
    snapshot_timestamp
FROM product_units
WHERE product_id = 6;

--Unforunately, re-running created multiple entries AND updated the timestamps, so I have to use rowid

DELETE FROM product_units
WHERE rowid = 4;

SELECT *
FROM product_units
WHERE product_id = 6;

--END QUERY


-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */
--QUERY 12

ALTER TABLE product_units
ADD current_quantity INT;

--Finding last value by most recent market date
SELECT product_id,
MAX(market_date) AS last_market_date
FROM vendor_inventory
GROUP BY product_id;

--Retrieving values
SELECT
vi.product_id,
vi.market_date,
vi.quantity
FROM vendor_inventory AS vi
WHERE vi.market_date = (
SELECT MAX(vi2.market_date)
FROM vendor_inventory AS vi2
WHERE vi2.product_id = vi.product_id
);

UPDATE product_units
SET current_quantity = COALESCE((
    SELECT vi.quantity
    FROM vendor_inventory AS vi
    WHERE vi.product_id = product_units.product_id
    AND vi.market_date = (
        SELECT MAX(vi2.market_date)
        FROM vendor_inventory AS vi2
        WHERE vi2.product_id = product_units.product_id
    )
), 0);

--Verifying
SELECT *
FROM product_units;

--END QUERY



