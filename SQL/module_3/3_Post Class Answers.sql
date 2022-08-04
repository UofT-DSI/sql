--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) */

CREATE TABLE temp.new_vendor AS
SELECT * FROM vendor

INSERT INTO temp.new_vendor
VALUES (10, "Thomass Superfood Store" , "Fresh Focused", "Thomas", "Rosenthal")

--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

--DENSE_RANK VERSION:
-- SELECT cp.*,
-- DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
-- 
-- FROM customer_purchases AS cp
-- 
-- ORDER BY customer_id, market_date

--ROW_NUMBER VERSION:
-- SELECT customer_id, market_date,
-- ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
-- 
-- FROM customer_purchases
-- 
-- GROUP BY customer_id, market_date
-- ORDER BY customer_id, market_date

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

--DENSE_RANK VERSION:
-- SELECT * FROM (
-- 	SELECT cp.*,
-- 	DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
-- 
-- 	FROM customer_purchases AS cp
-- ) x
-- WHERE x.visit_number =1
-- ORDER BY customer_id, market_date

--ROW_NUMBER VERSION:
-- SELECT * FROM (
-- 	SELECT customer_id, market_date,
-- 	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
-- 
-- 	FROM customer_purchases
-- 
-- 	GROUP BY customer_id, market_date
-- ) x
-- WHERE x.visit_number =1
-- ORDER BY customer_id, market_date


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

-- SELECT cp.*,
-- COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS
-- product_purchase_count
-- FROM customer_purchases AS cp
-- ORDER BY customer_id, product_id, market_date

/* Alterntively, if you interpretted this as a running count: */
/* running count version */
-- select customer_id, 
-- vendor_id, 
-- product_id, 
-- market_date, 
-- transaction_time, 
-- count() over (partition by customer_id, 
--   product_id 
--   order by market_date, 
--            transaction_time asc) as buy_count
-- from customer_purchases
-- order by customer_id, product_id, buy_count;

/*4. (we'll do this one together)
Using `SUM(COUNT(*)) OVER(...)` create two running totals: 
one for each cutomer for each product, and one for each customer. Use the previous query as a baseline. */

-- SELECT 
-- customer_id,
-- product_id,
-- COUNT(product_id) AS product_purchase_count,
-- 	
-- SUM(COUNT(*)) OVER (PARTITION BY customer_id
-- 	ORDER BY customer_id,product_id) AS total_customer_purchase_count
-- 
-- FROM customer_purchases AS cp
-- GROUP BY customer_id,product_id
-- 
-- ORDER BY customer_id

-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are! */

-- SELECT customer_id,
-- STRFTIME('%m',market_date) AS purchase_month,
-- STRFTIME('%Y', market_date) AS purchase_year
-- 
-- FROM customer_purchases

/* 2. What if we wanted to add each purchase month as another windowed group from previous our rolling totals query? */

-- SELECT 
-- customer_id,
-- product_id,
-- STRFTIME('%m',market_date) AS purchase_month,
-- COUNT(product_id) AS product_purchase_count,
-- 
-- SUM(COUNT(*)) OVER (PARTITION BY customer_id,product_id
-- 	ORDER BY customer_id,product_id, STRFTIME('%m',market_date)) AS total_product_purchase_count,
-- 	
-- SUM(COUNT(*)) OVER (PARTITION BY customer_id
-- 	ORDER BY customer_id,product_id, STRFTIME('%m',market_date)) AS total_customer_purchase_count
-- 
-- FROM customer_purchases AS cp
-- GROUP BY customer_id,product_id,STRFTIME('%m',market_date)
-- 
-- ORDER BY customer_id

-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

	SELECT 
	product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
	FROM product

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first problem, and 'unit' for the second problem. 

(Hint, keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. Edit the appropriate columns -- you're making two edits -- 
and the NULL rows will be fixed. All the other rows will remain the same.) */

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product

