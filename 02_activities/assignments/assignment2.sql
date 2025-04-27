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

SELECT 
product_name || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')'
FROM product;



--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

SELECT
	customer_id
	,market_date
	,ROW_NUMBER() OVER (
		PARTITION BY customer_id
		ORDER BY market_date
	) AS customer_visits
FROM  (
	SELECT DISTINCT	
		customer_id
		,market_date
	FROM customer_purchases
	);



/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

-- Recent visit is 1 (reverse order). Just add DESC to order by for market_date
SELECT
	customer_id
	,market_date
	,ROW_NUMBER() OVER (
		PARTITION BY customer_id
		ORDER BY market_date DESC
	) AS customer_visits
FROM  (
	SELECT DISTINCT	
		customer_id
		,market_date
	FROM customer_purchases
	)
	
	
-- Only get most recent visit
SELECT *
FROM (
	SELECT
		customer_id
		,market_date
		,ROW_NUMBER() OVER (
			PARTITION BY customer_id
			ORDER BY market_date DESC
		) AS customer_visits
	FROM  (
		SELECT DISTINCT	
			customer_id
			,market_date
		FROM customer_purchases
		)
	)
WHERE customer_visits = 1;



/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

SELECT
	*
	,COUNT(*) OVER (
		PARTITION BY customer_id, product_id 
		ORDER BY market_date, transaction_time
		) AS product_purchase_count
FROM customer_purchases
ORDER BY customer_id, product_id, market_date, transaction_time;



-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */

--Need to add +2 in SUBSTR because of the hyphen and the space after
SELECT 
	*
	,TRIM(IIF(INSTR(product_name, '-') > 0, SUBSTR(product_name, INSTR(product_name, '-') + 2), NULL)) AS description 
FROM product;



/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */

SELECT 
	*
	,TRIM(IIF(INSTR(product_name, '-') > 0, SUBSTR(product_name, INSTR(product_name, '-') + 2), NULL)) AS description 
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

SELECT 
	* 
FROM
	(--Get worst date (lowest sales)
	SELECT 
		market_date
		,SUM(quantity * cost_to_customer_per_qty) AS 'total_sales'
		,'worst day' AS 'sales_performance'
	FROM customer_purchases
	GROUP BY market_date
	ORDER BY total_sales ASC
	LIMIT 1
	) 

UNION

SELECT 
	* 
FROM
	(--Get best date (most sales)
	SELECT 
		market_date
		,SUM(quantity * cost_to_customer_per_qty) AS 'total_sales'
		,'best day' AS 'sales_performance'
	FROM customer_purchases
	GROUP BY market_date
	ORDER BY total_sales DESC
	LIMIT 1
	);



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

-- There are 3 vendors in vendor_inventory (vendor_id 4, 7, 8) and they have 8 products altogether.
-- There are 26 customers. We should expect the total records of customers purchasing to be (8*26) = 208.

-- Aggregate to find total sales per product_name
SELECT
	vendor_name
	,product_name
	,SUM(amount_to_sell)
FROM ( 
	-- Get all valid combinations of products and vendors from vendor_inventory
	SELECT 
		v.vendor_id
		,v.vendor_name
		,vi.product_id
		,cp.product_name
		,vi.original_price
		,(vi.original_price * 5) AS amount_to_sell
	FROM vendor v
	INNER JOIN (
		SELECT DISTINCT 
			vendor_id
			,product_id
			,original_price
		FROM vendor_inventory 
		) vi
		ON	v.vendor_id = vi.vendor_id

	-- Get all combinations of customers and products and join on relevant product_ids
	INNER JOIN (	
		SELECT * 
		FROM customer c
		CROSS JOIN product p
		) cp
		ON vi.product_id = cp.product_id
	)
GROUP BY product_name;



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

--Get table format for product
PRAGMA table_info(product);

--From this, we see the names and types as:
--	name				type
--	product_id			int(11)
--	product_name		varchar(45)
--	product_size		varchar(45)
--	product_category_id	int(11)
--	product_qty_type	varchar(45)



-- Delete table in case it already exists
DROP TABLE IF EXISTS product_units;

--Copy table format/columns of product, include snapshot_timestamp column
CREATE TABLE product_units (
	product_id INT(11)
	,product_name VARCHAR(45)
	,product_size VARCHAR(45)
	,product_category_id INT(11)
	,product_qty_type VARCHAR(45)
	,snapshot_timestamp TEXT
	);

--Insert 'unit' values, as well as the timestamp
INSERT INTO product_units
	SELECT 
		*
		,strftime('%Y-%m-%d %H:%M:%S', datetime('now')) AS 'snapshot_timestamp'
	FROM product
	WHERE product_qty_type = 'unit';

-- Checking if results look good	
SELECT * FROM product_units;



/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units VALUES(
	24
	,'Anchovy Martini'
	,'30 oz'
	,3
	,'unit'
	,strftime('%Y-%m-%d %H:%M:%S', datetime('now'))
	);

-- Checking if results look good		
SELECT * FROM product_units;



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units
WHERE product_name = 'Anchovy Martini';

-- Checking if results look good	
SELECT * FROM product_units;



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

ALTER TABLE product_units
ADD current_quantity INT;

DROP TABLE IF EXISTS temp_latest_inventory;

-- Get modified version of product_units as a temp table to join values 
CREATE TEMP TABLE temp_latest_inventory AS 
	-- Get all product_ids with current_quantity. It's set to 0 if it's not for the max date (Oct 13, 2023)
	SELECT 
		pu.*
		,vi_latest.*
		,COALESCE(vi_latest.quantity,0) AS latest_quantity
	FROM product_units pu
	LEFT JOIN (
		-- Inventory of latest date. If no record, means they were not available on that date
		SELECT vi.*
			,vi_latest_date.max_market_date
		FROM vendor_inventory vi
		INNER JOIN (
			-- Get the latest date for each product
			SELECT 
				MAX(market_date) AS max_market_date
			FROM vendor_inventory vi
		) vi_latest_date
		ON vi.market_date = vi_latest_date.max_market_date
	) vi_latest
	ON pu.product_id = vi_latest.product_id;

SELECT * FROM temp_latest_inventory;

-- Update statement for current_quantity, join on product_id
UPDATE product_units 
SET current_quantity = (
	SELECT latest_quantity	
	FROM temp_latest_inventory
	WHERE product_units.product_id = temp_latest_inventory.product_id
	);
	
-- Checking if results look good		
SELECT * FROM product_units;



