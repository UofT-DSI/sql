/* ASSIGNMENT 2 */
/* SECTION 2 */

--I tested with chinook. That .db doesn't work! Therefore, the correct file is farmersmarket.db

-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a 
blank for the first problem, and 'unit' for the second problem. 

HINT: keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. 
Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. 
All the other rows will remain the same.) */

/* Running the code from above, we can observe that ther there are NULL values located at row 13 and 14. 

*/ 
SELECT
  product_name || ', ' ||
  COALESCE(product_size, '') || ' (' ||
  COALESCE(product_qty_type, 'unit') || ')' AS product_display
FROM product;

--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

--using DENSE_RANK
SELECT
  cp.*,
  DENSE_RANK() OVER (
    PARTITION BY cp.customer_id
    ORDER BY DATE(cp.market_date)
  ) AS visit_no
FROM customer_purchases AS cp
ORDER BY cp.customer_id, DATE(cp.market_date);

--using ROW_NUMBER
WITH unique_visits AS (
  SELECT
    customer_id,
    DATE(market_date) AS visit_date
  FROM customer_purchases
  GROUP BY customer_id, DATE(market_date)  
)
SELECT
  customer_id,
  visit_date AS market_date,
  ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY visit_date
  ) AS visit_number
FROM unique_visits
ORDER BY customer_id, visit_date;

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

--Reverse the numbering so the most recent visit is labeled 1.
SELECT
  cp.*,
  DENSE_RANK() OVER (
    PARTITION BY cp.customer_id
    ORDER BY DATE(cp.market_date) DESC
  ) AS visit_no
FROM customer_purchases AS cp;

--Filter to only the most recent visit (the rows with visit_no = 1).
SELECT *
FROM (
  SELECT
    cp.*,
    DENSE_RANK() OVER (
      PARTITION BY cp.customer_id
      ORDER BY DATE(cp.market_date) DESC
    ) AS visit_no
  FROM customer_purchases AS cp
) AS ranked
WHERE ranked.visit_no = 1
ORDER BY ranked.customer_id, DATE(ranked.market_date);

/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

-- combinations: unique customer,product,visit-date combinations
WITH combinations AS (  
  SELECT DISTINCT
    customer_id,
    product_id,
    DATE(market_date) AS visit_date
  FROM customer_purchases
),
-- counts: window count per customer/product across unique visit dates
counts AS (      
  SELECT
    customer_id,
    product_id,
    visit_date,
    COUNT(*) OVER (
      PARTITION BY customer_id, product_id
    ) AS times_customer_bought_product
  FROM combinations
)
SELECT
  cp.*,
  c.times_customer_bought_product
FROM customer_purchases AS cp
JOIN counts AS c
  ON c.customer_id = cp.customer_id
 AND c.product_id  = cp.product_id
 AND c.visit_date  = DATE(cp.market_date)
ORDER BY cp.customer_id, cp.product_id, DATE(cp.market_date);

-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */

SELECT
  product_name,
  TRIM(
    SUBSTR(
      product_name,
      INSTR(product_name, '-') + 1
    )
  ) AS description
FROM product;

/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
SELECT 
  product_name,
  product_size
FROM product
WHERE product_size REGEXP '[0-9]';

-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */

-- total units per market date
WITH sales_by_date AS (       
  SELECT
    DATE(market_date) AS market_date,
    SUM(quantity)     AS total_units
  FROM customer_purchases
  GROUP BY DATE(market_date)
),
-- rank best/worst by total units
ranked AS (                   
  SELECT
    market_date,
    total_units,
    DENSE_RANK() OVER (ORDER BY total_units DESC) AS row_descending,
    DENSE_RANK() OVER (ORDER BY total_units ASC)  AS row_ascending
  FROM sales_by_date
)
-- UNION best day and worst day
SELECT
  market_date,
  total_units AS total,
  'best day'  AS best_and_worst
FROM ranked
WHERE row_descending = 1
UNION
SELECT
  market_date,
  total_units AS total,
  'worst day' AS best_and_worst
FROM ranked
WHERE row_ascending = 1
ORDER BY total DESC;

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

WITH vendor_products AS (
  SELECT
    v.vendor_name,
    p.product_name,
    AVG(vi.original_price) AS unit_price
  FROM vendor_inventory AS vi
  JOIN vendor  AS v ON v.vendor_id  = vi.vendor_id
  JOIN product AS p ON p.product_id = vi.product_id
  GROUP BY v.vendor_name, p.product_name
),
customers AS (
  SELECT customer_id FROM customer
)
SELECT
  vp.vendor_name,
  vp.product_name,
  SUM(5 * vp.unit_price) AS revenue_if_each_customer_buys_5
FROM vendor_products AS vp
CROSS JOIN customers AS c
GROUP BY vp.vendor_name, vp.product_name;

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
DROP TABLE IF EXISTS product_units;

CREATE TABLE product_units AS
SELECT
  p.*,
  CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product AS p
WHERE p.product_qty_type = 'unit';

--check if created correctly
--select * from product_units;


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units
SELECT
  p.*,
  CURRENT_TIMESTAMP
FROM product AS p
WHERE p.product_name = 'Apple Pie'
  AND p.product_qty_type = 'unit'
LIMIT 1;
--check if created correctly
--select * from product_units;


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

--since we added Apple Pie, will delete Apple Pie
DELETE FROM product_units
WHERE rowid = (
  SELECT rowid
  FROM product_units
  WHERE product_name = 'Apple Pie'
  ORDER BY snapshot_timestamp ASC, rowid ASC
  LIMIT 1
);

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

-- Add the column (from your prompt)
ALTER TABLE product_units
ADD current_quantity INT;

-- Set to last known quantity per product (or 0 if none)
UPDATE product_units AS pu
SET current_quantity = COALESCE((
  SELECT vi.quantity
  FROM vendor_inventory AS vi
  WHERE vi.product_id = pu.product_id
  ORDER BY DATE(vi.market_date) DESC, vi.rowid DESC
  LIMIT 1
), 0);


