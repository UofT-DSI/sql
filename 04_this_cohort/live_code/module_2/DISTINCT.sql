--DISTINCT

--without distinct, only wed/sat 150x
SELECT market_day
FROM market_date_info;

--with DISTINCT, only once each
SELECT DISTINCT market_day
FROM market_date_info;


SELECT * FROM customer_purchases;

/* which vendor has sold products to a customer */
SELECT DISTINCT vendor_id
FROM customer_purchases;

/* which vendor has sold products to a customer AND which product was it */
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases;

/* which vendor has sold products to a customer AND which product was it  and which customer bought it? */
SELECT DISTINCT vendor_id, product_id, customer_id -- im unsatisified with the ids! 
FROM customer_purchases
ORDER by product_id ASC, customer_id DESC