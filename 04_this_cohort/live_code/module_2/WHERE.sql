--WHERE

SELECT *
FROM customer
--WHERE customer_postal_code = 'M1L' -- only M1L
WHERE customer_postal_code IN ('M1L', 'M8Y'); -- M1L or M8Y

 -- dates farmers market was open in JUNE
SELECT *
FROM market_date_info
WHERE market_date BETWEEN '2022-06-01' AND '2022-06-30';

-- products with _tat_ or _ato_ in their names
SELECT * 
FROM product
WHERE product_name LIKE '%tat%' 
OR product_name LIKE '%ato%';


SELECT *
FROM market_date_info
WHERE market_year <> 2022; -- not 2022, but could be 2021, 2023, etc

-- what product_qty_types are missing in the product table
SELECT * 
FROM product
WHERE product_qty_type IS NULL;

-- what product_qty_type is blank
SELECT * 
FROM product
WHERE product_size = ''  -- must be two SINGLE QUOTES

