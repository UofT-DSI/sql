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
coalesce(product_name,'') || ', ' || coalesce(product_size, '')|| ' (' || coalesce(product_qty_type,'unit') || ')'
FROM product;



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

SELECT *, 
dense_rank () OVER (partition by  customer_id ORDER BY market_date ASC) AS purchase_number
 FROM customer_purchases
 WHERE market_date < '2022-04-29';



--END QUERY


/* 2. Reverse the numbering of the query so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit.
HINT: Do not use the previous visit dates filter. */
--QUERY 3

SELECT *
FROM (
SELECT *, 
dense_rank () OVER (partition by  customer_id ORDER BY market_date DESC) AS purchase_number
 FROM customer_purchases)
 WHERE purchase_number = 1;
 

--END QUERY


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. 

You can make this a running count by including an ORDER BY within the PARTITION BY if desired.
Filter the visits to dates before April 29, 2022. */
--QUERY 4

-- in order to test this:




SELECT customer_id, product_id,  count(*) OVER (PARTITION BY product_id, customer_id) as times_purchased
FROM customer_purchases
WHERE market_date < '2022-04-29'
ORDER BY customer_id ASC;

--END QUERY

-- In order to test the query executed SQL below and manually validated the results 
-- SELECT customer_id, product_id, market_date
-- FROM customer_purchases
-- WHERE market_date < '2022-04-29'
-- ORDER BY customer_id ASC

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

SELECT product_id, product_name, LTRIM(RTRIM(NULLIF(SUBSTR(product_name,INSTR(product_name, '-')+1),product_name))) as description
FROM PRODUCT ;



--END QUERY


/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
--QUERY 6

SELECT product_id, product_name,  LTRIM(RTRIM(NULLIF(SUBSTR(product_name,INSTR(product_name, '-')+1),product_name))) as description, product_size
FROM PRODUCT  
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



with daily_sales as (
SELECT market_date, sum (quantity*cost_per_quantity) as sales
FROM customer_purchases
GROUP BY market_date)


,ranked_daily_sales as (SELECT market_date, sales, 
dense_rank() OVER(ORDER BY sales DESC) AS ranked_sales
FROM daily_sales)

SELECT market_date, sales, ranked_sales
FROM ranked_daily_sales
WHERE ranked_sales = 1

UNION 

SELECT market_date, sales, ranked_sales
FROM ranked_daily_sales
WHERE ranked_sales = (SELECT max(ranked_sales) FROM ranked_daily_sales);



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

-- FIRST APPROACH - USED cost_per_quantity rom customer_purchases
-- 
-- with CTE_1 as (
-- 
-- SELECT DISTINCT v_i.vendor_id,  v_i.product_id, 5 as new_quantity, c.customer_id
-- FROM vendor_inventory v_i
-- CROSS JOIN
-- customer c
-- ),
-- 
-- CTE_2 as (
-- SELECT ct1.vendor_id, ct1.product_id, v.vendor_name, ct1.new_quantity, ct1.customer_id, c_p.cost_per_quantity, p.product_name
-- FROM CTE_1 ct1
-- LEFT JOIN 
-- customer_purchases c_p ON ct1.product_id = c_p.product_id AND ct1.vendor_id = c_p.vendor_id
-- INNER JOIN product p
-- ON ct1.product_id = p.product_id
-- INNER JOIN vendor v
-- ON ct1.vendor_id = v.vendor_id
-- )
-- 
-- SELECT vendor_name, product_name, SUM (new_quantity * COALESCE(cost_per_quantity, 0)) as sales_value
-- FROM CTE_2
-- GROUP BY vendor_name, product_name;


-- Second approach using original price from vendor_inventory


with CTE_1 as (

SELECT DISTINCT v_i.vendor_id,  v_i.product_id, v_i.original_price, 5 as new_quantity
FROM vendor_inventory v_i),

CTE_2 as (
SELECT ct1.vendor_id, ct1.product_id, ct1.original_price, ct1.new_quantity, c.customer_id
 FROM CTE_1 ct1
CROSS JOIN
customer c
),
 --SELECT * FROM CTE_2

CTE_3 as (
SELECT ct2.vendor_id, ct2.product_id, v.vendor_name, ct2.new_quantity, ct2.customer_id, ct2.original_price, p.product_name
FROM CTE_2 ct2
INNER JOIN product p
ON ct2.product_id = p.product_id
INNER JOIN vendor v
ON ct2.vendor_id = v.vendor_id
)

SELECT vendor_name, product_name, SUM (new_quantity * COALESCE(original_price, 0)) as sales_value
FROM CTE_3
GROUP BY vendor_name, product_name;

--END QUERY




-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
--QUERY 9

DROP TABLE IF EXISTS product_units;
CREATE TABLE IF NOT EXISTS product_units  AS

SELECT *, CURRENT_TIMESTAMP as snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

-- In order to test:
-- SELECT * FROM
-- product_units;

--END QUERY


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
--QUERY 10


INSERT INTO product_units values(25, 'Large Brown Eggs', '1 dozen', 6, 'unit', CURRENT_TIMESTAMP);

--END QUERY


-- DELETE
/* 1. Delete the older record for whatever product you added. 


HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
--QUERY 11


DELETE FROM product_units 
WHERE product_id = 25;

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

SELECT * FROM product_units;

ALTER TABLE product_units
ADD current_quantity INT;


DROP TABLE IF EXISTS temp.last_inventory_values;
CREATE TABLE IF NOT EXISTS temp.last_inventory_values AS
WITH CTE_1 as (

SELECT vendor_id, product_id, market_date, quantity, dense_rank() OVER(partition by product_id order by  market_date DESC ) as ranked_quantity
FROM vendor_inventory)
SELECT * FROM CTE_1
WHERE ranked_quantity = 1

-- In order to test
-- SELECT * FROM last_inventory_values;

UPDATE product_units
SET current_quantity = coalesce( 
(
SELECT quantity 
FROM last_inventory_values 
WHERE last_inventory_values.product_id = product_units.product_id),0);

-- IN ORDER TO TEST
-- SELECT * FROM product_units


--END QUERY



