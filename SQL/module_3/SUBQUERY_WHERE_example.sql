
SELECT *
FROM vendor_inventory

WHERE product_id IN (

	SELECT product_id
	FROM product
	
	WHERE product_name LIKE '%eppe%' )