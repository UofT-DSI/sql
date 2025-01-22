--LEFT JOIN

SELECT *
FROM product_category AS pc 
LEFT JOIN product AS p 
	ON pc.product_category_id = p.product_category_id
ORDER BY pc.product_category_id ;

-- different output! because product_category_id 4 is not in the product table!
SELECT *
FROM product AS pc 
LEFT JOIN product_category AS p 
	ON pc.product_category_id = p.product_category_id
ORDER BY pc.product_category_id ;
