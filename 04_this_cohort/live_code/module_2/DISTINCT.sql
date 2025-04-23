--DISTINCT

-- without distinct, 4221 rows, of various customer_ids 
SELECT customer_id FROM customer_purchases;

-- with DISTINCT, one row per customer, 26 rows total
SELECT DISTINCT customer_id FROM customer_purchases;

-- without distinct, only wed/sat 150 times over
SELECT market_day
FROM market_date_info;

-- market is open sat/wed!
SELECT DISTINCT market_day
FROM market_date_info;

/* which vendor has sold products to a customer */
SELECT DISTINCT vendor_id
FROM customer_purchases;  -- 3 rows, vendor_id 7,8,4



/* which vendor has sold products to a customer AND which product was it... */
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases; -- 8 rows

/* which vendor has sold products to a customer AND which product was it AND to whom was it sold ? */
SELECT DISTINCT vendor_id, product_id, customer_id -- this is dissatisfying...let's have a name!
FROM customer_purchases -- 200 rows
ORDER by product_id ASC, customer_id DESC

