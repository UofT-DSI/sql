--LEFT JOIN

SELECT * 
FROM product_category AS pc
LEFT JOIN product AS p
	ON pc.product_category_id = p.product_category_id;

	-- direction matters, 23 rows instead of 24 rows 
SELECT * 
FROM product AS pc
LEFT JOIN product_category AS p
	ON pc.product_category_id = p.product_category_id 
	
	
/* RIGHT JOIN CONCEPT 

SELECT * 
FROM product as p
RIGHT JOIN product_category as pc
	on pc.product_category_id = p.product_category_id
	
*/	