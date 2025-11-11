/* MODULE 2 */
/* WHERE */

/* 1. Select only customer 1 from the customer table */
SELECT * 
FROM customer
WHERE customer_id = 1;


/* 2. Differentiate between AND and OR */
SELECT * 
FROM customer
WHERE customer_id = 1
OR customer_id = 2;


/* 3. IN */
SELECT * 
FROM customer
WHERE customer_id IN (3,4,5)
OR customer_postal_code IN ('M4M','M1L'); -- customers in these postal codes


/* 4. LIKE */
-- all the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

--- customer with a last name starting with a
SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

/* 5. Nulls and Blanks*/

SELECT * FROM product
WHERE product_size IS NULL -- null
OR product_size = ''; -- blank, two single quotes not one double quote -- different from NULL


/* 6. BETWEEN x AND y */
SELECT * 
FROM customer
WHERE customer_id BETWEEN 1 AND 20;
--dates

SELECT market_date, market_day, market_year
FROM market_date_info

WHERE market_date BETWEEN '2022-10-01' AND '2022-10-31'
AND market_date = 'Wednesday';
