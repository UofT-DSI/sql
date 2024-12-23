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
--My answer:
SELECT
product_name || ', ' || COALESCE(product_size,'')|| ' (' ||COALESCE(product_qty_type, '') || ')'
FROM product


--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */
--My answer:
--ROW_NUMBER ()
1.
SELECT customer_id, market_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ) AS visit_number
FROM customer_purchases

GROUP BY customer_id, market_date
ORDER BY customer_id, market_date

2.
SELECT customer_id, market_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM customer_purchases

GROUP BY customer_id, market_date
-- 1 and 2 give the same output.

--DENSE_RANK()
SELECT customer_id, market_date,
DENSE_RANK() OVER (PARTITION BY customer_id ) AS visit_number

FROM customer_purchases

GROUP BY customer_id, market_date
ORDER BY customer_id, market_date

--At this case (distinct value) both ROW_NUMBER() and DENSE_RANK() return the same outputs.

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */
--My answer:
--ROW_NUMBER()
SELECT * 
  FROM 
  (SELECT customer_id, market_date,
  ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
  FROM customer_purchases

  GROUP BY customer_id, market_date
  ) x
WHERE x.visit_number =1
ORDER BY customer_id, market_date

--DENSE_RANK()
SELECT * 
  FROM 
  (SELECT customer_id, market_date,
  DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
  FROM customer_purchases
  
  GROUP BY customer_id, market_date
  ) x
WHERE x.visit_number =1
ORDER BY customer_id, market_date

/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */
--My answer:
SELECT customer_id, 
       vendor_id, 
       product_id, 
       market_date, 
       transaction_time,   
COUNT() OVER (PARTITION BY customer_id, 
              product_id ORDER BY market_date, 
              transaction_time asc) as buy_count
FROM customer_purchases
ORDER BY customer_id, product_id, buy_count


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */
--My answer:
SELECT product_name, 
       CASE WHEN INSTR(product_name,'-') > 0
            THEN LTRIM(RTRIM(SUBSTR(product_name,INSTR(product_name,'-')+1)))
            ELSE NULL END AS description
FROM product

/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
--My answer:
SELECT *, 
       CASE WHEN INSTR(product_name,'-') > 0
            THEN LTRIM(RTRIM(SUBSTR(product_name,INSTR(product_name,'-')+1)))
            ELSE NULL END AS description
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
--My answer:
-- Step 1: Create a CTE to calculate total sales for each date
;WITH SalesByDate AS (
    SELECT 
        market_date,
        ROUND(SUM(quantity * cost_to_customer_per_qty),2) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),

-- Step 2: Create another CTE to rank the dates by total sales
RankedSales AS (
    SELECT 
        market_date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS rank_highest,
        RANK() OVER (ORDER BY total_sales ASC) AS rank_lowest
    FROM SalesByDate
)

-- Step 3: Query for the best and worst days using UNION
SELECT 
    market_date,
    total_sales,
    'Best Day' AS sales_type
FROM RankedSales
WHERE rank_highest = 1

UNION

SELECT 
    market_date,
    total_sales,
    'Worst Day' AS sales_type
FROM RankedSales
WHERE rank_lowest = 1;

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

--My answer:
-- Step 1: Select relevant vendor and product details
;WITH VendorProducts AS (
    SELECT DISTINCT
        v.vendor_name,
        p.product_name,
        vi.original_price
    FROM vendor_inventory vi
    JOIN vendor v on v.vendor_id = vi.vendor_id
    JOIN product p on p.product_id = vi.product_id
    ),

-- Step 2: Table of customers
CustomerCount AS (
    SELECT COUNT(*) AS total_customers
	FROM customer
		 ),


-- Step 3: Calculate revenue for every vendor-product combination
VendorRevenue AS (
    SELECT 
        vp.vendor_name,
        vp.product_name,
        vp.original_price * 5 * cc.total_customers AS total_revenue
    FROM VendorProducts vp
    CROSS JOIN CustomerCount cc
)

-- Step 4: Final output
SELECT 
    vendor_name,
    product_name,
    total_revenue
FROM VendorRevenue
ORDER BY vendor_name, product_name;
  
	  
-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

--My answer:
CREATE TABLE product_units AS
             SELECT p.*,
                  CURRENT_TIMESTAMP AS snapshot_timestamp
 FROM product AS p
 WHERE product_qty_type = "unit"

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
--My answer:
INSERT INTO product_units (
            product_id, 
			product_name,
            product_size, 
			product_category_id, 
			product_qty_type, 
			snapshot_timestamp)
     VALUES (
        101,                     -- Replace with a unique product_id
       'Apple Pie',             -- Example product_name
       'Medium',                -- Example product_size
       3,                       -- Example product_category_id (e.g., baked goods)
        'Piece',                 -- Example product_qty_type
    CURRENT_TIMESTAMP        -- Automatically sets the current timestamp
);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

--My answer:
WITH older_record AS
    (SELECT product_id,MIN(snapshot_timestamp) AS snapshot_timestamp
     FROM product_units 
     WHERE product_id = 101)

DELETE FROM product_units
WHERE (product_id = 
  (SELECT  product_id 
     FROM older_record
    )
AND snapshot_timestamp =  
  (SELECT  snapshot_timestamp 
  FROM older_record
    ))

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
--My answer:
--Step 1: Add the current_quantity Column
ALTER TABLE product_units
ADD current_quantity INT;

--Step 2: Determine the "Last" Quantity per Product
WITH LastQuantityPerProduct AS (
        SELECT 
          product_id,
          quantity,
          ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS rn
        FROM vendor_inventory
        )
        SELECT 
          product_id,
          COALESCE(quantity, 0) AS last_quantity
        FROM LastQuantityPerProduct
        WHERE rn = 1;

--Step 3: Update current_quantity in the product_units Table
UPDATE product_units
SET current_quantity = (
	 SELECT COALESCE(quantity, 0)
     FROM (
        SELECT 
            product_id,
            quantity,
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY snapshot_timestamp DESC) AS rn
        FROM vendor_inventory
    ) AS LastQuantity
    WHERE LastQuantity.product_id = product_units.product_id
    AND LastQuantity.rn = 1
)
WHERE EXISTS (
    SELECT *
    FROM vendor_inventory
    WHERE vendor_inventory.product_id = product_units.product_id
);
 --Final Check
 SELECT * FROM product_units;

