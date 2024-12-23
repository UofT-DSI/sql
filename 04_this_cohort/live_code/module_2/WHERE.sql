--WHERE

SELECT *
FROM customer
WHERE customer_id = 1
OR customer_id = 2; -- 1 or 2
--AND customer_id = 2 -- returns nothing

--IN
SELECT *
FROM customer_purchases
WHERE customer_id IN (3,4,5) -- only customers 3, 4 and 5
AND vendor_id IN (3,4,5);

SELECT * 
FROM product
WHERE product_name LIKE '%pepper%'; -- find all the peppers

SELECT * FROM product
WHERE product_id IN (1,2)
OR product_size = 'Medium';

SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

SELECT * FROM product
WHERE product_size IS NULL
OR product_size = '' -- blank, different from a single space = ' '