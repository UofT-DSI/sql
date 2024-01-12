-- LEFT JOIN


SELECT DISTINCT vendor_name, customer_id, product_id
FROM vendor
LEFT JOIN customer_purchases
	ON vendor.vendor_id = customer_purchases.vendor_id

/*
SELECT DISTINCT customer_id, product_id, vendor_name
FROM customer_purchases
LEFT JOIN vendor
	ON vendor.vendor_id = customer_purchases.vendor_id
	*/