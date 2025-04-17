-- INNER JOIN
-- no alias INNER JOIN

/* get product names alongside customer_purchases...only products that a customer has purchased will be present */
SELECT 
product_name, -- coming from product
vendor_id, -- coming from cp...below
market_date,
customer_id,
customer_purchases.product_id

FROM customer_purchases
INNER JOIN product
	ON customer_purchases.product_id = product.product_id;
	
/* which vendor has sold products to a customer AND which product was it AND to whom was it sold ? */
SELECT DISTINCT vendor_id, 
product_id, 
--customer_id -- this is dissatisfying...let's have a name!
customer_first_name,
customer_last_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON cp.customer_id = c.customer_id
