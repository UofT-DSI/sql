-- multiple table joins


/*
SELECT cp.*,p.*,v.*, product_category_name
FROM customer_purchases cp
INNER JOIN product p 
	ON p.product_id = cp.product_id
INNER JOIN vendor v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product_category pc
	ON p.product_category_id = pc.product_category_id
	
	*/
	
SELECT product_category_name, p.*, cp.product_id

FROM product_category as pc
INNER JOIN product as p
	ON p.product_category_id = pc.product_category_id
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id