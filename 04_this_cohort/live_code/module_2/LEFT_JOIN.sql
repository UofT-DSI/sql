-- LEFT JOIN

SELECT DISTINCT p.product_id, product_name, cp.* -- cp.* = all columns  in customer_purchases table
FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id;

SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p -- table 1
LEFT JOIN customer_purchases as cp -- table 2
	ON p.product_id = cp.product_id;

-- the same as the query above -- you cant run this though
--SELECT DISTINCT p.product_id, product_name, cp.product_id
--FROM customer_purchases as p -- table 1 
--RIGHT JOIN product as cp -- table 2
--	ON p.product_id = cp.product_id;
	
SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id
/* if we add this where statement, we are explicitly asking for "what products haven't been sold at the farmers market */	
WHERE cp.product_id IS NULL;


SELECT DISTINCT p.product_id, product_name, cp.product_id
FROM product as p -- table 1
LEFT JOIN customer_purchases as cp -- table 2
	ON p.product_id = cp.product_id
WHERE cp.product_id is NULL

SELECT c.customer_id, cp.customer_id FROM customer_purchases cp INNER JOIN customer c ON c.customer_id= cp.customer_id
