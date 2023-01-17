/*
NTILE for vendor 7, who sells 4 items, therefore grouping them into their own groups bsaed on their price
...but if we had price variance for products by market date, we would be able to show averages, rolling averages, etc
*/

SELECT x.*, product_name

FROM (

	SELECT DISTINCT
	y.*
	,NTILE(4) OVER (PARTITION BY vendor_id ORDER BY original_price DESC) as price_quartile
	
	FROM (
		SELECT DISTINCT 
		vendor_id
		,product_id
		,original_price
		FROM vendor_inventory
		WHERE vendor_id = 7 
		) y
	) x
JOIN product p
	ON x.product_id = p.product_id

ORDER BY vendor_id, product_id
	