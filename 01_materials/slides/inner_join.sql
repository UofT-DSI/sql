--INNER JOIN


SELECT * from customer_purchases;

SELECT * from product;


--get product names alongside customer_purchases ...only products that a customer has purchased

SELECT product_name,
vendor_id,
market_date,
customer_id,
customer_purchases.product_id

FROM customer_purchases
INNER JOIN product
ON customer_purchases.product_id = product.product_id;



SELECT DISTINCT vendor_id,
c.customer_id,
customer_first_name,
customer_last_name,
product_id
FROM customer_purchases AS CP
INNER JOIN customer AS c
ON c.customer_id = cp.customer_id;




