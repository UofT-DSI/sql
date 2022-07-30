SELECT * 

FROM (

	SELECT DISTINCT
	vendor_id
	,market_date
	,product_id
	,original_price
	,ROW_NUMBER() OVER ( PARTITION BY vendor_id ORDER by original_price DESC) AS price_rank

	FROM vendor_inventory vi 
) x
WHERE price_rank = 1