-- INTERSECT / EXCEPT

--products that have been sold (e.g. are in the customer_purchases AND product)
-- direction does not matter

SELECT product_id
FROM customer_purchases
INTERSECT
SELECT product_id
FROM product;

--products that have NOT been sold (e.g. are NOT in customer_purchases even though they are in product)
SELECT x.product_id, product_name
FROM (
	SELECT product_id
	FROM product
	EXCEPT 
	SELECT product_id 
	FROM customer_purchases
) x
JOIN product p on x.product_id = p.product_id

--NOTHING!
-- direction matters....
SELECT product_id
FROM customer_purchases
EXCEPT 
SELECT product_id 
FROM product