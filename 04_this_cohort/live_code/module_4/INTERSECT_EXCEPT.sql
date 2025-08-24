-- INTERSECT / EXCEPT

-- products that have been sold (e.g. are in the customer_purchases and product)

SELECT product_id
FROM customer_purchases
INTERSECT
SELECT product_id
FROM product;

-- products that have NOT been sold (e.g. are NOT in customer_purchases even though they are in product)
SELECT product_name, x.product_id
FROM 
(
	SELECT product_id
	FROM product
	EXCEPT
	SELECT product_id
	FROM customer_purchases
) x
JOIN product p on x.product_id = p.product_id;

-- sold products that are not in the products table ... not possible
-- NOTHING 
SELECT product_id
FROM customer_purchases
EXCEPT
SELECT product_id
FROM product