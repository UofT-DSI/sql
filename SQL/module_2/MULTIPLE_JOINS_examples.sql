-- MULTIPLE JOINs

SELECT DISTINCT
product_name, quantity,vendor_name,customer_first_name, customer_last_name

FROM product p
INNER JOIN customer_purchases cp
	ON p.product_id = cp.product_id
INNER JOIN vendor v 
	ON v.vendor_id = cp.vendor_id
INNER JOIN customer c
	ON c.customer_id = cp.customer_id