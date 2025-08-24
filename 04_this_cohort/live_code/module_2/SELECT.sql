-- SELECT 

-- select everything from the customer TABLE
SELECT * 
FROM customer;

-- use sql as a calculator
SELECT 1+1, 10*5, pi();

--add a static value
SELECT 2025 as this_year, 'August' as this_month, customer_id
FROM customer;

-- add an order by and limit 
SELECT * 
FROM customer
ORDER BY customer_first_name
LIMIT 10;

-- select multiple columns
SELECT customer_id, customer_first_name
FROM customer;

