--DISTINCT
--4221 ROWS
SELECT * from customer_purchases;

--4221 ROWS
SELECT customer_id from customer_purchases;

--26 ROWS
SELECT DISTINCT(customer_id) from customer_purchases;

--150 Days 
SELECT market_date FROM market_date_info;

--2 Days only Sat. and Wed
SELECT DISTINCT(market_day) FROM market_date_info;


SELECT * from customer_purchases;


SELECT DISTINCT(vendor_id) from customer_purchases;


SELECT DISTINCT vendor_id, product_id from customer_purchases;


SELECT DISTINCT vendor_id, product_id, customer_id from customer_purchases
ORDER BY product_id ASC, customer_id DESC




