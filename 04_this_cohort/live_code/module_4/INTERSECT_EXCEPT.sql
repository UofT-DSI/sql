--INTERSECT / EXCEPT

--product that have been sold (e.g are in customer_purchases and product)
SELECT product_id
FROM customer_purchases
INTERSECT -- similar to the inner join in this case
SELECT product_id
FROM product;

--products that NOT been sold (e.g. are NOT in customer_pruchases even though in product) 
-- add the name
SELECT x. product_id, product_name
FROM (
	SELECT product_id
	FROM product -- what products are NOT in customer_purchases
	EXCEPT
	SELECT product_id
	FROM customer_purchases
) x 
JOIN product p on x.product_id = p.product_id
	
--NOTHING
--direction matter a lot!
SELECT product_id
FROM  customer_purchases -- what products are NOT in product -- NONE!
EXCEPT
SELECT product_id
FROM product;



