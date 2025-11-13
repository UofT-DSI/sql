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
OR customer_id = 2; -- 1 or 2
--AND customer_id -- returns nothing


/* 3. IN */
SELECT * FROM customer
WHERE customer_id IN (3,4,5,6); -- only customers 3,4,5,6


/* 4. LIKE */
SELECT * 
FROM product
WHERE product_name LIKE '%pepper%';

SELECT * 
FROM customer
WHERE customer_last_name LIKE 'a%'; -- starting with a


/* 5. Nulls and Blanks*/
SELECT * 
FROM product
WHERE product_size IS NULL -- missing, null VALUES
OR product_size = ''; -- two single quotes '' not a double quote "


/* 6. BETWEEN x AND y */
SELECT * FROM market_date_info
WHERE market_date BETWEEN '2022-03-01' AND '2022-05-31' -- works well with dates or numbers!
