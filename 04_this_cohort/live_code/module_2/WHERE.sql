-- WHERE

SELECT * FROM customer
WHERE customer_id = 1
OR customer_id = 2;         -- 1 or 2
--AND customer_id = 2 -- returns nothing

--IN
SELECT * FROM customer
WHERE customer_id IN (3,4,5) -- only customers 3,4,5
OR customer_postal_code IN ('M4H','M1L'); --  customers in these postal codes

--LIKE
-- all the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

--customer with a last name starting with a
SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

--NULLS and Blanks
SELECT * FROM product
WHERE product_size IS NULL
OR product_size = ''; -- two single quotes, "blanks", different from nulls

-- between another option
SELECT * 
FROM customer 
WHERE customer_id BETWEEN 1 AND 20



