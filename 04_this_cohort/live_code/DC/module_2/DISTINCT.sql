/* MODULE 2 */
/* DISTINCT */


/* 1. Compare how many customer_ids are the customer_purchases table, one select with distinct, one without */

-- 4221 rows
SELECT customer_id FROM customer_purchases;

SELECT DISTINCT customer_id FROM customer_purchases;



/* 2. Compare the difference between selecting market_day in market_date_info, with and without distinct:
 what do these difference mean?*/
-- market is open for 150 days
 SELECT market_day
 FROM market_date_info;
 
 -- market is only open on 2 days, wed and sat
 SELECT DISTINCT market_day
 FROM market_date_info;
 
 

/* 3. Which vendor has sold products to a customer */
-- 3 vendors have sold products
SELECT DISTINCT vendor_id
FROM customer_purchases;


/* 4. Which vendor has sold products to a customer ... and which product was it */
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases;


/* 5. Which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/
SELECT DISTINCT vendor_id, product_id,customer_id
FROM customer_purchases
