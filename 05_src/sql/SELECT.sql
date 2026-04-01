SELECT* FROM customer;

SELECT 1+1 AS addition, 10*5 AS multiplication, pi() AS pi;

SELECT*
FROM customer
ORDER BY customer_first_name
LIMIT 10;

SELECT customer_first_name, customer_last_name
FROM customer; 

SELECT 2026 as this_year, 'March' as this_month, customer_id
FROM customer;

SELECT * 
FROM customer
WHERE customer_id IN (3,4,5,6);

SELECT * FROM product
WHERE product_name LIKE '%pepper%';

SELECT *
FROM product
WHERE product_size IS NULL
OR product_size = '';

SELECT *
FROM customer
WHERE customer_id BETWEEN 1 AND 20;
--dates

SELECT *
FROM market_date_info

SELECT *
FROM market_date_info
WHERE market_date BETWEEN '2022


		
