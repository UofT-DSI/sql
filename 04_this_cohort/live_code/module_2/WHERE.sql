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
AND customer_id = 2; -- OR is two rows, AND is 0 rows


/* 3. IN */
SELECT * 
FROM customer
WHERE customer_id IN (3,5,6,7);



/* 4. LIKE */
-- find all the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';


/* 5. Nulls and Blanks*/
SELECT * FROM product
WHERE product_size IS NULL 
OR product_size = ''; -- blank, two single quotes NOT one double quote, different from NULL


/* 6. BETWEEN x AND y */
SELECT * 
FROM customer
WHERE customer_id BETWEEN 1 AND 20
ORDER BY customer_id ASC;

--dates
SELECT * 
FROM market_date_info
WHERE market_date BETWEEN '2022-10-01' AND '2022-10-31'


--------------------------------------------------------------------------------------------------------------------------------------------
