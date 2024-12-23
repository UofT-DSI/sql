--LEFT JOIN

--there are products that have been bought, but are there products that haven't been bought?
SELECT DISTINCT p.product_id, p.product_name
,cp.* -- cp.* = all columns in the customer purchases table
FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id;
	
SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id;
	
--WHERE cp.product_id IS NOT NULL -- what products have been sold (remove NOT to show the opposite)

--directions matter a lot!
SELECT DISTINCT  cp.product_id, p.product_id, product_name
FROM customer_purchases as p
LEFT JOIN product as cp
	ON p.product_id = cp.product_id;
	
SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id
WHERE cp.product_id is NULL -- have never been sold
	
