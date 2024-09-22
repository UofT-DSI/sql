--LEFT JOIN

SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p
LEFT JOIN customer_purchases as cp
 ON	p.product_id = cp.product_id
 
WHERE cp.product_id IS NULL