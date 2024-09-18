--windowed function
--what product is the highest price per vendor

SELECT * 

FROM (
		SELECT 
		vendor_id
		,market_date
		,product_id
		,original_price
		,ROW_NUMBER() OVER(PARTITION BY vendor_id,product_id ORDER BY original_price DESC) as price_rank
		
		FROM vendor_inventory
) x

WHERE x.price_rank = 1;


-- SELECT 
-- 		vendor_id
-- 		,market_date
-- 		,product_id
-- 		,original_price
-- 
-- FROM vendor_inventory
-- order by original_price DESC