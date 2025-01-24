--INNER JOIN

SELECT * 
FROM product -- on the left
INNER JOIN product_category
	ON product.product_category_id = product_category.product_category_id;
	

SELECT 
product_category_name, p.*  -- only product_category_name and then everything from p product
FROM product_category AS pc -- on the left
INNER JOIN product AS p -- on the right
	ON pc.product_category_id = p.product_category_id -- same result set (but we lost row for "product_category_id = 4" because not in the product table
ORDER BY pc.product_category_id ASC;