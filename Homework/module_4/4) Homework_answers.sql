--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

/*
--DENSE_RANK

SELECT cp.*,
DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number

FROM customer_purchases AS cp

ORDER BY customer_id, market_date


--ROW_NUMBER

SELECT customer_id, market_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number

FROM customer_purchases

GROUP BY customer_id, market_date
ORDER BY customer_id, market_date

*/

/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */


/*

--DENSE_RANK

SELECT * FROM (
	SELECT cp.*,
	DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number

	FROM customer_purchases AS cp
) x
WHERE x.visit_number =1
ORDER BY customer_id, market_date


--ROW_NUMBER

SELECT * FROM (
	SELECT customer_id, market_date,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number

	FROM customer_purchases

	GROUP BY customer_id, market_date
) x
WHERE x.visit_number =1
ORDER BY customer_id, market_date

*/


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

/*
SELECT cp.*,
COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS
product_purchase_count
FROM customer_purchases AS cp
ORDER BY customer_id, product_id, market_date
*/

/*4. **CHALLENGING**
Using `SUM(COUNT(*)) OVER(...)` create two running totals: 
one for each cutomer for each product, and one for each customer. Use the previous query as a baseline. */

/*
SELECT 
customer_id,
product_id,
COUNT(product_id) AS product_purchase_count,
	
SUM(COUNT(*)) OVER (PARTITION BY customer_id
	ORDER BY customer_id,product_id) AS total_customer_purchase_count

FROM customer_purchases AS cp
GROUP BY customer_id,product_id

ORDER BY customer_id
*/


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */



/* 2. FIlter the query to show any product_size value that contain a number with REGEXP. */


--Cross Join
/*1. Suppose every customer on record bought each item the vendor has in their inventory (for a single day). 
How much money would each vendor make per product? 
Show this by vendor_name (concatenate first and last) and product name, rather than using the IDs. */


/*
SELECT DISTINCT vendor_name
,sum(original_price) AS total

FROM (
	SELECT DISTINCT vendor_owner_first_name || ' ' || vendor_owner_last_name AS vendor_name
	,product_name
	,customer_name
	,original_price


	FROM vendor_inventory vi
	INNER JOIN vendor v ON v.vendor_id = vi.vendor_id
	INNER JOIN product p ON p.product_id = vi.product_id

	CROSS JOIN 
		(SELECT DISTINCT customer_first_name || ' ' || customer_last_name AS customer_name FROM customer
		)
) x
GROUP BY vendor_name,product_name
*/

/* 2. What if we want to include every day the market is open? 
Modify the query to show how much each vendor could make. */
SELECT DISTINCT vendor_name
,sum(original_price) AS total

FROM (
	SELECT DISTINCT vendor_owner_first_name || ' ' || vendor_owner_last_name AS vendor_name
	,product_name
	,customer_name
	,original_price
	,market_date


	FROM vendor_inventory vi
	INNER JOIN vendor v ON v.vendor_id = vi.vendor_id
	INNER JOIN product p ON p.product_id = vi.product_id

	CROSS JOIN 
		(SELECT DISTINCT customer_first_name || ' ' || customer_last_name AS customer_name FROM customer
		)
) x
GROUP BY vendor_name