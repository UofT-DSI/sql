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

--- Answer-- 

SELECT 
    product_name || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')' AS [PRODUCT_LONG_LIST]
FROM product;


--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

-- Answer -- 

-- I went with dense rank and distinct because I wanted to get one row per unique market date per customer to avoid duplicate dates --

SELECT 
    customer_id AS [CUSTOMER_ID],
    market_date AS [MARKET_DATE],
    DENSE_RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY market_date
    ) AS [VISIT_NUMBER]
FROM 
	(
		SELECT DISTINCT 
			customer_id, 
			market_date
		FROM customer_purchases
	) AS unique_visits;

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

-- Answer --

SELECT *
FROM 
(
    SELECT 
        customer_id,
        market_date,
        DENSE_RANK() OVER (
            PARTITION BY customer_id 
            ORDER BY market_date DESC -- most recent visit as labeled 1 by descending order--
        ) AS visit_number
    FROM (
        SELECT DISTINCT 
			customer_id, 
			market_date
        FROM customer_purchases
    ) AS unique_visits
) AS ranked_visits
WHERE visit_number = 1;



/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

-- Answer -- 

SELECT 

	DISTINCT -- this is to account for the dups --
    customer_id AS [CUSTOMER_ID],
    product_id AS [PRODUCT_ID],
    COUNT(*) OVER (
        PARTITION BY customer_id, product_id
    ) AS [PURCHASE_INSTANCES]
FROM customer_purchases

ORDER BY customer_id, product_id; -- to show it nicely--


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */

-- Answer -- I am approaching with NULLs being available after the query in cases where SUBSTR will return the desired value or otherwise will remain NULL. 

SELECT 
    product_name AS [PRODUCT_NAME],
    CASE 
        WHEN INSTR(product_name, '-') > 0 
		THEN 
            TRIM(
				SUBSTR(product_name, 
					INSTR(product_name, '-') + 1))
        ELSE NULL
    END AS [DESCRIPTION]
FROM product


/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */

--Answer-- In this solution I am using the previous query and including a new column to how the product size.
SELECT 
    product_name AS [PRODUCT_NAME],
	product_size AS [PRODUCT_SIZE],
    CASE 
        WHEN INSTR(product_name, '-') > 0 
		THEN 
            TRIM(
				SUBSTR(product_name, 
					INSTR(product_name, '-') + 1))
        ELSE NULL
    END AS [DESCRIPTION]
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

-- Step 1: Creating a CTE to aggregate sum total sales by date
WITH sales_by_date AS (
    SELECT 
        market_date,
        SUM([quantity] * [cost_to_customer_per_qty]) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),

-- Step 2: Rank the days (best and worst)
ranked_sales AS (
    SELECT 
        market_date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS best_rank,--DESC first record is best day--
        RANK() OVER (ORDER BY total_sales ASC) AS worst_rank -- ASC first record is the worst day--
    FROM sales_by_date
),

-- Step 3: Find the best day--
best_day AS (
	SELECT 
		'Best Day' AS label,
		market_date,
		total_sales
	FROM ranked_sales
	WHERE best_rank = 1),

-- Step 4: Find the worst day --
worst_day AS (
	SELECT 
		'Worst Day' AS label,
		market_date,
		total_sales
	FROM ranked_sales
	WHERE worst_rank = 1)
	
-- Step 5 -- Now we union both datasets
SELECT * FROM best_day
UNION
SELECT * FROM worst_day;
	

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

-- Answer --
-- Step 1: Since the table has duplicated entries lets get unique combo of product_id, and price first, check was done to ensure product prices don't change-
-- This approach is better for performance--
WITH 
price_product_list AS
(	 SELECT DISTINCT
        vendor_id,
        product_id,
        original_price
    FROM vendor_inventory
),

-- Step 2: Now lets focus on each customer buying all the products from the inventory, hence a cross join here --

cross_sales AS (
    SELECT DISTINCT
        ppl.vendor_id,
        ppl.product_id,
        ppl.original_price,
        c.customer_id
    FROM price_product_list ppl
    CROSS JOIN customer c
),

-- Step 3: Each customer buys 5 units, so revenue = p x q (5)
revenue_per_product AS (
    SELECT 
        cs.vendor_id,
        cs.product_id,
        SUM(5 * cs.original_price) AS total_revenue
    FROM cross_sales cs
    GROUP BY cs.vendor_id, cs.product_id
)

-- Step 3: Final step to obtain the vendor name and product name
SELECT 
    v.vendor_name AS [VENDOR_NAME],
    p.product_name AS [PRODUCT_NAME],
    ROUND(r.total_revenue, 2) AS [TOTAL_REVENUE] -- just looks better--
FROM revenue_per_product r
INNER JOIN vendor v ON r.vendor_id = v.vendor_id
INNER JOIN product p ON r.product_id = p.product_id
ORDER BY v.vendor_name, p.product_name; 



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

DROP TABLE IF EXISTS product_units;

CREATE TABLE product_units AS
SELECT 
    *, 
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

SELECT * FROM product_units


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
--Answer -- 

-- Step 1: Insert value--
INSERT INTO product_units (
    product_id, 
    product_name, 
    product_size, 
	product_category_id,
    product_qty_type, 
    snapshot_timestamp
)
SELECT 
    max(product_id) + 1, -- incrementing by one unit
    'Apple Pie',
    '10"',
	3,
    'unit',
    CURRENT_TIMESTAMP
FROM product_units;

SELECT * FROM product_units
ORDER BY product_id DESC; -- check to see that insertion went as expected--
-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units
WHERE product_name = 'Apple Pie'
AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp)
    FROM product_units
    WHERE product_name = 'Apple Pie' -- subquery to get the earliest snapshot_timestamp for the apple pie record, since we are deleting the older record--
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

-- Alter table step: Alter table to add values--
ALTER TABLE product_units
ADD current_quantity INT;

-- Step 1: Get a CTE which includes products with NO inventory records in those case assume none in inventory (assign 0)
WITH no_inventory_products AS (
    SELECT 
        pu.product_id,
        0 AS current_quantity
    FROM product_units pu
    WHERE pu.product_id NOT IN (
        SELECT DISTINCT product_id FROM vendor_inventory
    )
),

-- -- Step 2: Create a CTE to get last quantity per product when it is available on the inventory which is based on market_date in my opinion
latest_inventory_products AS (
    SELECT 
        vi.product_id,
        COALESCE(vi.quantity, 0) AS current_quantity --in case the quantity is NULL--
    FROM (
        SELECT 
            product_id,
            quantity,
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS rn
        FROM vendor_inventory
    ) vi
    WHERE vi.rn = 1
),

-- Step 3: Combine both sets to create a full inventory CTE(products with and without inventory)
final_quantity_data AS (
    SELECT * FROM no_inventory_products
    UNION
    SELECT * FROM latest_inventory_products
)

-- Step 4: Update product_units table using full_quantity_data CTE
UPDATE product_units
SET current_quantity = (
    SELECT fqd.current_quantity
    FROM final_quantity_data fqd
    WHERE fqd.product_id = product_units.product_id
)
WHERE product_id IN (SELECT product_id FROM final_quantity_data);

-- Check if the statement accomplished the work--
SELECT * 
FROM product_units;