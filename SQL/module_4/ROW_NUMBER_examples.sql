-- ROW_NUMBER

--Find the most expensive item a given vendor sells

SELECT DISTINCT x.*, product_name

FROM (

	SELECT
	vendor_id
	,market_date
	,product_id
	,original_price
	,ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank
	
	FROM vendor_inventory ) x
JOIN product p
	ON x.product_id = p.product_id
	
WHERE price_rank = 1