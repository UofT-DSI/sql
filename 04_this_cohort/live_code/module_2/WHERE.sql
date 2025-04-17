-- WHERE

SELECT * FROM customer
WHERE customer_id = 1
OR customer_id = 2; -- 1 or 2
--AND customer_id = 2 -- returns nothing

--IN
SELECT * FROM customer_purchases
WHERE customer_id IN (3,4,5) -- only customers 3,4,5 
AND vendor_id IN (3,4,5);

--LIKE
-- all of the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

-- customers with a last name starting with a
SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

--NULLs and Blanks
SELECT * FROM product
WHERE product_size IS NULL
OR product_size = '' -- two single quotes, "blank" -- different than null





