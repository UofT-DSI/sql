-- SELECT 

--selecting everything from customer
SELECT *
FROM customer;

-- adding some static values
SELECT 2024 as this_year, 'December' as this_month, customer_id
FROM customer;

--math
SELECT 10*5;

-- add an order by
SELECT * 
FROM customer
ORDER BY customer_last_name DESC