--windowed function
-- what was the highest price seen per product for each vendor

SELECT *

FROM (

	SELECT DISTINCT
	vendor_id
	--,market_date
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id,product_id ORDER BY original_price DESC) as price_rank

	FROM vendor_inventory
	WHERE vendor_id = 7
) x

WHERE x.price_rank = 1
