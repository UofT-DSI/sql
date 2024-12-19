-- INNER JOIN
-- no alias inner JOIN

SELECT customer_purchases.product_id, 
product.product_id, 
product_name, 
vendor_id, 
market_date, 
customer_id

FROM customer_purchases 
INNER JOIN product
	ON customer_purchases.product_id = product.product_id;
	
--/* which vendor has sold products to a customer AND which product was it */
SELECT DISTINCT p.product_id, product_name, vendor_id
FROM customer_purchases as cp -- get the purchases, get the vendor
INNER JOIN product as p -- get the name of the product
	ON p.product_id = cp.product_id