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
	
-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

-- SELECT 
--  vendor_id --, booth_number
-- ,count(*) AS no_of_days
-- 
-- FROM vendor_booth_assignments
-- GROUP BY vendor_id --, booth_number


/* 2. Using your cherry pie query, show how much money each customer has spent on cherry pies. */

-- SELECT DISTINCT
-- customer_first_name,
-- customer_last_name,
-- product_name,
-- SUM(quantity * cost_to_customer_per_qty) as total_cherry_pie_cost
-- 
-- FROM customer_purchases cp
-- INNER JOIN customer c
-- 	ON c.customer_id = cp.customer_id
-- INNER JOIN product p
-- 	ON cp.product_id = p.product_id
-- 
-- WHERE p.product_id = 8
-- GROUP BY customer_first_name,
-- customer_last_name,
-- product_name
-- 
-- ORDER BY total_cherry_pie_cost DESC


/* (don't do this one yet, we didn't get to HAVING) 
3. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $50 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 
(HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.) */

SELECT 
cp.customer_id,
c.customer_first_name,
c.customer_last_name,
SUM(quantity * cost_to_customer_per_qty) total_spent

FROM customer_purchases cp
INNER JOIN customer c 
	ON c.customer_id = cp.customer_id

GROUP BY cp.customer_id,
c.customer_first_name,
c.customer_last_name

HAVING total_spent > 2000

ORDER BY customer_last_name, customer_first_name

