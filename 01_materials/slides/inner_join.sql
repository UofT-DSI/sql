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




SELECT DISTINCT vendor_id, customer_id, product_id
FROM customer_purchases
ORDER BY customer_id ASC, product_id DESC


-- multiple_table_joins

/* which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/ 
SELECT DISTINCT 
--customer_id, 
customer_first_name,
customer_last_name,
--vendor_id, 
vendor_name,
--product_id
product_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id;
	
	
/* what if we add the dates they were purchased ? */
SELECT DISTINCT 
market_date,
--customer_id, 
customer_first_name,
customer_last_name,
--vendor_id, 
vendor_name,
--product_id
product_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id;

	


