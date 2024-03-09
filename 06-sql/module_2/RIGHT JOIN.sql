
-- RIGHT JOIN , not supported but these queries are equiv
SELECT *

FROM product AS p
LEFT JOIN product_category AS pc
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id

SELECT * 
FROM product_category As pc
RIGHT JOIN product AS p
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id