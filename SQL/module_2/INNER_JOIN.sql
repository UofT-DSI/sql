--INNER JOIN

/*
SELECT p.product_id, p.product_name, p.product_size, p.product_category_id,  p.product_qty_type
, pc.product_category_name
FROM product p
INNER JOIN product_category pc
	ON p.product_category_id = pc.product_category_id
*/

-- not a meaningful query, but valid
-- SELECT * 
-- FROM product p
-- INNER JOIN product_category pc
-- 	ON p.product_id = pc.product_category_id

SELECT DISTINCT vendor_name, product_id
FROM vendor
INNER JOIN customer_purchases
	ON vendor.vendor_id = customer_purchases.vendor_id

