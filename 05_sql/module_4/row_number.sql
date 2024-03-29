--windowed function

--what product is the highest price per vendor)
SELECT *

FROM (
		SELECT 
		vendor_id
		,market_date
		,product_id
		,original_price
		,ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) as price_rn

		FROM vendor_inventory
) x

WHERE x.price_rn = 1;

--whats the max price per product per vendor, not the same
SELECT vendor_id,
--product_id,
MAX(original_price)

FROM vendor_inventory
GROUP BY vendor_id;--,product_id
