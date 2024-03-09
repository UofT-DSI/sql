--multiple table joins

/*

SELECT cp.*, p.*,v.*, pc.*

FROM customer_purchases AS cp
INNER JOIN product p 
	ON cp.product_id = p.product_id
INNER JOIN vendor v
	ON cp.vendor_id = v.vendor_id
INNER JOIN product_category pc
	ON p.product_category_id = pc.product_category_id
	
*/

SELECT  product_category_name, p.*,cp.product_id as productid_in_purchases_table

FROM product_category AS pc
INNER JOIN product AS p
	ON p.product_category_id = pc.product_category_id
LEFT JOIN customer_purchases cp
	ON p.product_id = cp.product_id
