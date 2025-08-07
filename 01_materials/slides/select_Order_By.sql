--SELECT

--Select everything from the customer table
SELECT * FROM customer;

--use sql as a calculator
SELECT 1+1, 10*5, pi();

--add a static value
SELECT 2025 as this_year, 'August' as this_month, customer_id
FROM customer;

--ass an order by limit
SELECT *
FROM customer
ORDER BY customer_first_name
LIMIT 10;

/*Another comment*/

select 10+5 from customer;
SELECT [customer_id] from customer;
