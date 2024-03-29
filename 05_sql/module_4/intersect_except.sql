--INTERSECT / EXCEPT

-- products that have been sold (e.g. are in customer purchases AND product)
SELECT product_id
FROM product
INTERSECT
SELECT product_id
FROM customer_purchases

-- products that have NOT been sold (e.g. are NOT in customer purchases even though in product)
SELECT product_id
FROM product
EXCEPT
SELECT product_id
FROM customer_purchases

-- products that do not exist, because no products purchased are NOT in the product table (e.g. are NOT in product even though in customer purchases)
SELECT product_id
FROM customer_purchases
EXCEPT
SELECT product_id
FROM product

--full details within a WHERE statement
SELECT * FROM
product
WHERE product_id IN (
	SELECT product_id
	FROM product
	INTERSECT
	SELECT product_id
	FROM customer_purchases
)