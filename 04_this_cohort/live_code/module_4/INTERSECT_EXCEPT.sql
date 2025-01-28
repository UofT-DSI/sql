--INTERSECT / EXCEPT


-- products that have been sold (e.g. are in the customer_purchases and product)
SELECT product_id
FROM customer_purchases
INTERSECT
SELECT product_id
FROM product;

-- products that have NOT been sold

SELECT x.product_id, product_name -- adding the name!
FROM (
	SELECT product_id
	FROM product -- what products are NOT in customer_purchases
	EXCEPT
	SELECT product_id
	FROM customer_purchases
) x
JOIN product p on x.product_id = p.product_id;


SELECT product_id
FROM customer_purchases -- what products sold were  NOT in product table -- NONE!
EXCEPT
SELECT product_id
FROM product
