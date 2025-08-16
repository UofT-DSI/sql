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

SELECT *
FROM product;

SELECT 
product_name || ', '|| coalesce(product_size, ' ')|| ' (' || coalesce(product_qty_type, 'unit') || ')'
FROM product;

--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
from customer_purchases;

SELECT * 
FROM(
	SELECT 
	customer_id,
	market_date,
	dense_rank() OVER(PARTITION BY customer_id ORDER BY market_date ) as ranking_visits
	FROM customer_purchases
	) x
ORDER BY customer_id, ranking_visits;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (
	SELECT 
	customer_id,
	market_date,
	row_number() OVER(PARTITION BY customer_id ORDER BY market_date) as ranking_uniq_visits
	FROM (
	SELECT DISTINCT customer_id, market_date
	FROM customer_purchases) as unique_values
) x
ORDER BY customer_id, ranking_uniq_visits;

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (
	SELECT 
	customer_id,
	market_date,
	row_number() OVER(PARTITION BY customer_id ORDER BY market_date DESC) as ranking_uniq_visits
	FROM (
	SELECT DISTINCT customer_id, market_date
	FROM customer_purchases) as unique_values
) x
WHERE ranking_uniq_visits = 1
ORDER BY customer_id;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM(
	SELECT *
	FROM (
		SELECT 
		customer_id,
		market_date,
		row_number() OVER(PARTITION BY customer_id ORDER BY market_date) as ranking_uniq_visits
		FROM (
		SELECT DISTINCT customer_id, market_date
		FROM customer_purchases) as unique_values
	) as unique_values
) as recent_visits
ORDER BY ranking_uniq_visits  ASC;


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

SELECT *
FROM (
	SELECT *, 
	count(quantity) OVER(PARTITION BY customer_id) as n_purchases
	FROM customer_purchases
	) x
ORDER BY customer_id;

SELECT
    *,
    COUNT(*) OVER (PARTITION BY customer_id, product_id) AS times_customer_purchased_product
FROM customer_purchases;


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */


-- SELECT *
-- FROM product;

SELECT 
	product_name, 
	substr(trim(product_name),  instr(product_name, '-')+2) as description
	
FROM product
WHERE substr(trim(product_name),  instr(product_name, '-')+2) in ('Organic', 'Jar');


  
/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */

SELECT 
    product_id, 
    product_name, 
    product_category_id, 
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

-- 1.-----------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH sales_values AS (
    SELECT 
        market_date,
        SUM(quantity * cost_to_customer_per_qty) AS sales
    FROM customer_purchases
    GROUP BY market_date
),
worst_day_ranking AS (
    SELECT
        market_date,
        sales,
        ROW_NUMBER() OVER (ORDER BY sales ASC) AS ranking_days
    FROM sales_values
),
best_day_ranking AS (
    SELECT
        market_date,
        sales,
        ROW_NUMBER() OVER (ORDER BY sales DESC) AS ranking_days
    FROM sales_values
)

SELECT 
    market_date AS day_type,
    sales,
    ranking_days,
    'worst_day' AS label
FROM worst_day_ranking
WHERE ranking_days = 1

UNION

SELECT 
    market_date AS day_type,
    sales,
    ranking_days,
    'best_day' AS label
FROM best_day_ranking
WHERE ranking_days = 1;

-- 2.-----------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH sales_values AS (
	SELECT
		market_date, 
		SUM(quantity * cost_to_customer_per_qty) AS sales
	FROM customer_purchases
	GROUP BY market_date),
	best_day AS (
		SELECT market_date,
			sales,
			'best_day' as label
		FROM sales_values
		ORDER BY sales DESC
		LIMIT 1
	),
	worst_day AS (
		SELECT market_date,
			sales,
			'worst_day' AS label
		FROM sales_values
		ORDER BY sales ASC
		LIMIT 1
	)
	SELECT * from best_day
	UNION
	SELECT * from worst_day;
	


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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT vi.vendor_id,
	v.vendor_name
FROM vendor_inventory vi
LEFT JOIN vendor v
	ON v.vendor_id = vi.vendor_id;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT customer_id
FROM customer;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WITH unique_customers AS (
		SELECT count(DISTINCT customer_id) as total_customers
		FROM customer
), 
vendors_table AS (
	SELECT vi.product_id,
		p.product_name,
		v.vendor_name,
		v.vendor_id,
		original_price,
		sum(original_price * 5) as total_rev
	FROM   vendor_inventory vi 
	LEFT JOIN vendor v
		ON v.vendor_id = vi.vendor_id
	LEFT JOIN product p
		ON p.product_id = vi.product_id
	GROUP BY vi.vendor_id	
)
SELECT 
	vt.vendor_name,
	vt.vendor_id,
	vt.product_name,
	vt.total_rev,
	vt.original_price * 5 * uc.total_customers AS total_revenue
FROM vendors_table vt
CROSS JOIN unique_customers uc
ORDER BY vt.vendor_name, vt.product_name;
-- vt.original_price * 5 * uc.total_customers DESC;


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

DROP TABLE IF EXISTS temp.product_units;

CREATE TABLE temp.product_units AS
SELECT *,
CURRENT_TIMESTAMP AS 'snapshot_timestamp'
FROM product
WHERE product_qty_type = 'unit';

SELECT * 
FROM product_units;


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO temp.product_units 
VALUES (24, 'Apple Pie', '10"', 3, 'unit', CURRENT_TIMESTAMP);

SELECT * 
FROM temp.product_units;

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM temp.product_units
WHERE product_id = 24;

SELECT *
FROM temp.product_units;

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


-- SELECT * 
-- FROM temp.product_units;
-- 
-- SELECT 
-- product_id,
-- -- quantity, 
-- market_date,
-- last_value(quantity) OVER(PARTITION BY product_id ORDER BY market_date DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastQuantity
-- FROM vendor_inventory
-- WHERE product_id=16
-- -- ORDER by market_date DESC
-- LIMIT 1;
-- 
-- 
-- SELECT * 
-- FROM temp.product_units
-- WHERE product_id = 16;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE temp.product_units
ADD current_quantity INT;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE temp.product_units
set current_quantity =  coalesce(current_quantity, 0);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE temp.product_units
SET current_quantity = (SELECT 
last_value(quantity) OVER(PARTITION BY product_id ORDER BY market_date DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastQuantity
FROM vendor_inventory
WHERE product_units.product_id = vendor_inventory.product_id
-- ORDER by market_date DESC
LIMIT 1);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE product_units
SET current_quantity = 0
WHERE current_quantity IS NULL;

SELECT *
FROM product_units;



