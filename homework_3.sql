--AGGREGATE
--1.
SELECT vendor_id, count (*)
FROM vendor_booth_assignments
GROUP BY vendor_id;
--2.
SELECT c.customer_id, customer_first_name, customer_last_name, sum(quantity * cost_to_customer_per_qty) AS cost 
FROM customer c
INNER JOIN customer_purchases cp
ON c.customer_id = cp.customer_id
GROUP BY c.customer_id
HAVING cost > 2000
ORDER BY customer_last_name, customer_first_name

--Temp Table
DROP TABLE IF EXISTS temp.new_vendor;
CREATE TEMP TABLE temp.new_vendor AS
SELECT *
FROM vendor;

INSERT INTO temp.new_vendor 
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

--Date
--1.
SELECT customer_id
,strftime('%m', market_date) AS month
,strftime('%Y', market_date) AS year
FROM customer_purchases;
--2.
SELECT customer_id
,strftime('%m', market_date) AS month
,strftime('%Y', market_date) AS year
,sum(quantity*cost_to_customer_per_qty) AS money_spent
FROM customer_purchases
WHERE month = '04' AND year = '2022'
GROUP BY customer_id;
