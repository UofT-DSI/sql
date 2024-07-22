--INTERSECT / EXCEPT

--products that have been sold (e.g. are in customer purchases and product)
SELECT product_id
FROM product
INTERSECT
SELECT product_id
FROM customer_purchases;

--products that have NOT been sold (e.g. are NOT in customer purchases even though in product)
--plus their names!
SELECT x.product_id,product_name FROM (
	SELECT product_id
	FROM product
	EXCEPT
	SELECT product_id
	FROM customer_purchases ) x
JOIN product p on x.product_id = p.product_id;


--products that do not exist, because no product purchased is NOT in the product table

--NOTHING!!
SELECT product_id
FROM customer_purchases
EXCEPT
SELECT product_id
FROM  product

--can put it in a where clause instead
SELECT * FROM 
product
WHERE product_id IN (
	SELECT product_id
	FROM product
	EXCEPT
	SELECT product_id
	FROM customer_purchases)