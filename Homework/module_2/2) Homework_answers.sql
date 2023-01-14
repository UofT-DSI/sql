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
-- WHERE vendor_id BETWEEN 8 AND 10

--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */
-- SELECT 
-- product_id,
-- product_name,
-- CASE WHEN product_qty_type = 'unit' THEN 'unit'
--    ELSE 'bulk' END AS prod_qty_type_condensed
-- 
-- FROM product


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
-- SELECT 
-- product_id,
-- product_name,
-- CASE WHEN product_qty_type = 'unit' THEN 'unit'
--    ELSE 'bulk' END AS prod_qty_type_condensed,
-- CASE WHEN product_name LIKE '%eppers%' THEN 1
--    ELSE 0 END AS pepper_flag
-- 
-- FROM product


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */
-- SELECT *
-- 
-- FROM vendor v
-- INNER JOIN vendor_booth_assignments vba
-- 	ON v.vendor_id = vba.vendor_id
-- 
-- ORDER BY v.vendor_name, vba.market_date

/* 2. Since SQLite doesn't have RIGHT JOIN, rewrite this query with a LEFT JOIN:
SELECT *
FROM customer AS c
RIGHT JOIN customer_purchases AS cp
    ON c.customer_id = cp.customer_id
*/

-- SELECT * 
-- 
-- FROM customer_purchases cp
-- LEFT JOIN customer AS c
-- 	ON cp.customer_id = c.customer_id

/* 3. Write a query that shows a customer's name  (customer_first_name, customer_last_name) 
who has bought a cherry pie. Include the column that shows the Cherry Pie product name. */
-- SELECT DISTINCT
-- customer_first_name,
-- customer_last_name,
-- product_name
-- 
-- FROM customer_purchases cp
-- INNER JOIN customer c
-- 	ON c.customer_id = cp.customer_id
-- INNER JOIN product p
-- 	ON cp.product_id = p.product_id
-- 
-- WHERE p.product_id = 8
-- ORDER BY customer_last_name, customer_first_name