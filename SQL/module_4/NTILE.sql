-- NTILE

SELECT DISTINCT
vendor_id
,product_id
,original_price
,price_ntile

FROM (

	SELECT 
	vendor_id
	,market_date
	,product_id
	,original_price
	,NTILE(10) OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_ntile
	
	FROM vendor_inventory ) x
	
ORDER BY original_price