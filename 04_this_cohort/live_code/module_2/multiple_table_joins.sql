--multiple table JOINs 

/* which vendor has sold products to a customer AND which product was it AND to whom was it sold ? */
SELECT DISTINCT 
--vendor_id, 
vendor_name,
--product_id, 
product_name,
--customer_id -- this is dissatisfying...let's have a name!
customer_first_name,
customer_last_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON cp.customer_id = c.customer_id
INNER JOIN vendor as v
	ON cp.vendor_id = v.vendor_id
INNER JOIN product as p
	ON cp.product_id = p.product_id;
	
/* what if we add the dates they were purchased
which vendor has sold products to a customer AND which product was it AND to whom was it sold ? */
SELECT DISTINCT 
market_date,
--vendor_id, 
vendor_name,
--product_id, 
product_name,
--customer_id -- this is dissatisfying...let's have a name!
customer_first_name,
customer_last_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON cp.customer_id = c.customer_id
INNER JOIN vendor as v
	ON cp.vendor_id = v.vendor_id
INNER JOIN product as p
	ON cp.product_id = p.product_id
	
ORDER BY customer_first_name, customer_last_name, product_name, market_date