-- LEFT JOIN
SELECT *

FROM product_category AS pc
LEFT JOIN product AS p
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id


/*
SELECT DISTINCT pc.product_category_id, p.product_category_id

FROM product_category AS pc
LEFT JOIN product AS p
	ON pc.product_category_id = p.product_category_id
	
WHERE pc.product_category_id BETWEEN 1 and 6 -- different if you do p.product_category_id, because #4 not in p.product_category_id

ORDER by pc.product_category_id
*/