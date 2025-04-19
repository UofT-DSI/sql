-- SELECT 

--selecting everything from customer
SELECT * 
FROM customer;

-- add a static value
SELECT 2025 as this_year, 'April' as this_month, customer_id
FROM customer;

-- add an order by + limit
SELECT * 
FROM customer
ORDER BY customer_last_name
LIMIT 10
