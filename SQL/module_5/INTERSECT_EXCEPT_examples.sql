--INTERSECT & EXCEPT

/*
SELECT product_id
FROM product
INTERSECT
SELECT product_id 
FROM customer_purchases
*/

SELECT * FROM
product
WHERE product_id IN (	
	SELECT product_id
	FROM product
	INTERSECT
	SELECT product_id 
	FROM customer_purchases)

/*
SELECT product_id
FROM product
EXCEPT
SELECT product_id 
FROM customer_purchases
*/

