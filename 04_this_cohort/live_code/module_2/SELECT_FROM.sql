--SELECT / FROM

--SELECT * FROM customer

/* -- comment out several lines of code
SELECT product_name, 
product_category_id, 
product_qty_type
FROM product
*/

SELECT
'2025' as this_year,
customer_first_name,
10*5 as calculation,
12 / 3,
1+1

FROM customer;

SELECT 
customer_first_name as first_name
FROM customer
