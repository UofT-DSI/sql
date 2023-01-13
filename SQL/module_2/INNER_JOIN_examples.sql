--INNER JOIN


SELECT *

FROM product p
INNER JOIN product_category pc 
	ON p.product_category_id = pc.product_category_id


/*
SELECT product.*, product_category_name
,product.product_category_id

FROM product
INNER JOIN product_category
	ON product.product_category_id = product_category.product_category_id
*/