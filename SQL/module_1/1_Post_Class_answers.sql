--SELECT
/* 1. Write a query that returns everything in the customer table. */
--SELECT * FROM customer


/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */
-- SELECT *
-- FROM customer
-- ORDER BY customer_last_name, customer_first_name
-- LIMIT 10

/* 3. Write a query that lists all customer IDs and first names in the customer table, sorted by first_name. */
-- SELECT
-- customer_id
-- ,customer_first_name
-- 
-- FROM customer
-- ORDER BY customer_first_name


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1
-- SELECT * 
-- FROM customer_purchases
-- WHERE product_id IN (4,9) 

-- option 2
-- SELECT * 
-- FROM customer_purchases
-- WHERE product_id = 4
-- OR product_id = 9 

/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
-- SELECT 
-- product_id
-- ,vendor_id
-- ,market_date
-- ,customer_id
-- ,quantity
-- ,cost_to_customer_per_qty
-- ,quantity * cost_to_customer_per_qty AS price
-- ,transaction_time
-- 
-- FROM customer_purchases
-- WHERE vendor_id >= 8 
-- AND vendor_id <= 10

-- option 2
SELECT 
product_id
,vendor_id
,market_date
,customer_id
,quantity
,cost_to_customer_per_qty
,quantity * cost_to_customer_per_qty AS price
,transaction_time

FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10
