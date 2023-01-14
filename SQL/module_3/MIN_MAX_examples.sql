-- MIN & MAX

/*
SELECT MIN(customer_first_name), MAX(customer_first_name)

FROM customer
*/


SELECT MIN(original_price), MAX(original_price)
,vendor_id, product_id

FROM vendor_inventory
GROUP BY vendor_id, product_id