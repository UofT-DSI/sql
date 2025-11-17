/* MODULE 2 */
/* DISTINCT */


/* 1. Compare how many customer_ids are the customer_purchases table, 
one select with distinct, one without */

-- 4221 rows
SELECT customer_id FROM customer_purchases;

-- 26 rows
SELECT DISTINCT customer_id FROM customer_purchases;


/* 2. Compare the difference between selecting market_day in market_date_info, with and without distinct:
 what do these difference mean?*/
 
 -- 150 rows...days that market was open
 SELECT market_day FROM market_date_info;
 
-- the market is only open on wed and saturday
 SELECT DISTINCT market_day FROM market_date_info;
 

/* 3. Which vendor has sold products to a customer */
SELECT DISTINCT vendor_id
FROM customer_purchases; -- 3rows


/* 4. Which vendor has sold products to a customer ... and which product was it */
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases; -- 8 rows


/* 5. Which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/
SELECT DISTINCT vendor_id, product_id, customer_id
FROM customer_purchases
ORDER BY customer_id ASC, product_id DESC -- 200 rows

