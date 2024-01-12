-- MULTIPLE JOINS

/*
SELECT DISTINCT vendor_name, customer_first_name, customer_last_name, 
--customer_id,
product_id
FROM vendor
LEFT JOIN customer_purchases
	ON vendor.vendor_id = customer_purchases.vendor_id
INNER JOIN customer
	ON customer.customer_id = customer_purchases.customer_id
	
	ORDER BY vendor_name, customer_first_name, customer_last_name
	*/
	
/*

SELECT DISTINCT vendor_name, customer_first_name, customer_last_name, 
--customer_id,
product_id
FROM vendor
LEFT JOIN customer_purchases
	ON vendor.vendor_id = customer_purchases.vendor_id
LEFT JOIN customer
	ON customer.customer_id = customer_purchases.customer_id	
*/

SELECT DISTINCT vendor_name, customer.customer_id, customer_first_name, customer_last_name, 
product.product_id, product_name
--customer_id,
--product_id
FROM vendor
LEFT JOIN customer_purchases
	ON vendor.vendor_id = customer_purchases.vendor_id
LEFT JOIN customer
	ON customer.customer_id = customer_purchases.customer_id
LEFT JOIN product
	ON product.product_id = customer_purchases.product_id