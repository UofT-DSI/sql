/* ASSIGNMENT 2 */
/* SECTION 2 */

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
--====================================================================================================================
-- Solution COALESCE.
--====================================================================================================================
SELECT 
  COALESCE(product_name, '') || ', ' || product_size || ' (' || COALESCE(product_qty_type, 'unit') || ')'
FROM product;

--====================================================================================================================
-- End of solution COALESCE.
--====================================================================================================================

--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */
--====================================================================================================================
-- Solution windowed functions number 1.
--====================================================================================================================
WITH CTE_visit_number AS ( 
	SELECT 
		customer_id,
		market_date,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY market_date) as visit_number
	FROM customer_purchases
)

SELECT 
	DISTINCT visit_number,
	customer_id,
	market_date
FROM CTE_visit_number;
--====================================================================================================================
-- End of solution windowed functions number 1.
--====================================================================================================================

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */
--====================================================================================================================
-- Solution windowed functions number 2.
--====================================================================================================================
WITH CTE_visit_number AS (
	SELECT 
		customer_id,
		market_date,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY market_date DESC) as visit_number
	FROM customer_purchases
)

SELECT 
    customer_id,
    market_date,
    visit_number
FROM CTE_reverse_visit_number
WHERE visit_number = 1;
--====================================================================================================================
-- End of solution windowed functions number 2.
--====================================================================================================================
/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */
--====================================================================================================================
-- Solution COUNT 
--====================================================================================================================
WITH  CTE_product AS (
	SELECT
		customer_id,
		product_id,
		COUNT() OVER(PARTITION BY customer_id, product_id) as product_bought_number
	FROM customer_purchases
)
SELECT DISTINCT
	customer_id,
	product_id,
	product_bought_number
FROM CTE_product;

--====================================================================================================================
-- End of solution COUNt
--====================================================================================================================
-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */
--====================================================================================================================
-- Solution string manipulation number 1.
--====================================================================================================================
WITH CTE_hypen AS (
SELECT 
	*,
  TRIM(SUBSTR(product_name, 1, INSTR(product_name, '- ') - 1)) AS product_name_clear
FROM product
)
SELECT
	CASE
		WHEN LENGTH(product_name_clear) > 0 THEN product_name_clear
		ELSE product_name
	END AS product_name,

<<<<<<< HEAD
	CASE
		WHEN LENGTH(product_name_clear) > 0 THEN TRIM(SUBSTR(product_name, INSTR(product_name, '- ') + 2), -1)
		ELSE ''
	END AS description
FROM CTE_hypen;
--====================================================================================================================
-- End of solution string manipulation number 1.
--====================================================================================================================
/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
--====================================================================================================================
-- Solution string manipulation number 2. 
--====================================================================================================================
SELECT 
	*
FROM product 
WHERE product_size REGEXP '\d';
--====================================================================================================================
-- End of solution string manipulation number 2.
--====================================================================================================================
=======



>>>>>>> 13ea50bee14e2d70d843287064b166add9c253da
-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */
--====================================================================================================================
-- Solution UNION.
--====================================================================================================================
WITH CTE_purchase AS (
	SELECT
		*,
		quantity * cost_to_customer_per_qty as purchase_each
	FROM customer_purchases
), CTE_daily_sales AS (
	SELECT DISTINCT
		market_date,
		SUM(purchase_each) OVER(PARTITION BY market_date) as daily_sales
	FROM CTE_purchase
), CTE_sales_minimum AS (
	SELECT
		*
	FROM CTE_daily_sales
	ORDER BY daily_sales 
	LIMIT 1
), CTE_sales_maximum AS (
	SELECT
		*
	FROM CTE_daily_sales
	ORDER BY daily_sales DESC
	LIMIT 1
)

SELECT
	*
FROM CTE_sales_minimum

UNION

SELECT
	*
FROM CTE_sales_maximum;
--====================================================================================================================
-- End of solution UNION.
--====================================================================================================================

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
--====================================================================================================================
-- Solution of CROSS JOIN
--====================================================================================================================
WITH CTE_vendor AS (
	SELECT
		vendor_id,
		product_id,
		original_price
	FROM vendor_inventory
), CTE_customer AS (
	SELECT
		customer_id
	FROM customer
), CTE_cross_join AS (
	SELECT
		cv.vendor_id,
		cv.product_id,
		cv.original_price,
		cc.customer_id
	FROM CTE_vendor AS cv
	CROSS JOIN CTE_customer AS cc
), CTE_5products_sold AS (
	SELECT
		*,
		5 AS number_product_sold
	FROM CTE_cross_join
), CTE_total_sales AS (
	SELECT
		*,
		original_price * number_product_sold AS sales_5products
	FROM CTE_5products_sold
)

SELECT DISTINCT 
	product_id,
	vendor_id,
	SUM(sales_5products) OVER(PARTITION BY product_id ORDER BY vendor_id) AS sales_each_product
FROM CTE_total_sales
--====================================================================================================================
-- End of solution CROSS JOIN 
--====================================================================================================================
-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
--====================================================================================================================
-- Solution INSERT number 1
--====================================================================================================================
DROP TABLE IF EXISTS product_units;
CREATE TABLE product_units AS
SELECT
	*,
	CURRENT_TIMESTAMP AS snapshoot_timestamp
FROM product
WHERE product_qty_type = 'unit';

SELECT
	*
FROM product_units;
--====================================================================================================================
-- End of solution INSERT number 1
--====================================================================================================================
/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
--====================================================================================================================
-- Solution INSERT number 2.
--====================================================================================================================
INSERT INTO product_units
VALUES(7,'Big Apple Pie', '20 inch', 3, 'unit', CURRENT_TIMESTAMP);

SELECT
	* 
FROM product_units
--====================================================================================================================
-- End of solution INSERT number 2
--====================================================================================================================
-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
--====================================================================================================================
-- Solution DELETE.
--====================================================================================================================
DELETE FROM product_units 
WHERE product_name = 'Big Apple Pie';

SELECT
	*
FROM product_units;
--====================================================================================================================
-- End of solution DELETE 
--====================================================================================================================
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

--===========================================================================================
-- Create a new column called current_quantity in product_units table
--===========================================================================================
ALTER TABLE product_units 
ADD COLUMN current_quantity INT;

--===========================================================================================
-- Create a new table called TABLE_update_market contains current_quantity throught 3 CTEs
--===========================================================================================
DROP TABLE IF EXISTS TABLE_update_market;
CREATE TABLE TABLE_update_market AS
WITH CTE_rank_market_date AS(
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY market_date DESC) as rank_market_date
	FROM vendor_inventory
), CTE_last_market_date AS (
	SELECT
		*
	FROM CTE_rank_market_date
	WHERE rank_market_date = 1
), CTE_update_market_date AS (
	SELECT
		*,
		COALESCE(clmd.quantity,0) as quantity_nonull
	FROM product_units as pu
	LEFT JOIN CTE_last_market_date as clmd
	ON clmd.product_id = pu.product_id
)

SELECT
*
FROM CTE_update_market_date;

--===============================================================================================================
-- Update the current_quantity column of product_units table with quantity_nonull column from TABLE_update_market
--===============================================================================================================

UPDATE product_units AS pu
SET  current_quantity = tum.quantity_nonull
FROM TABLE_update_market AS tum
WHERE pu.product_id = tum.product_id;

--===============================================================================================================
-- Result of current_quantity column from product_units has been updated succesfully.
--===============================================================================================================
SELECT
	*
FROM product_units;



