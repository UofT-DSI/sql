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
WHERE customer_id IN (3,4,5,6);

/* 4. LIKE */
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

/* 5. Nulls and Blanks*/
SELECT * FROM product
WHERE product_size IS NULL -- null
OR product_size = ''; -- blank, 2 single quotes, not a double one, different from NULL 

/* 6. BETWEEN x AND y */
SELECT * FROM customer
WHERE customer_id BETWEEN 1 AND 20

--------------------------------------------------------------------------------------------------------------------------------------------
