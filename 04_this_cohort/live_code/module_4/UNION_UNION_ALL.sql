--UNION/UNION ALL

--most and least expensive product per vendor with a UNION

SELECT vendor_id, product_id, original_price, rn_max as [row_number]
FROM 
(
	SELECT DISTINCT
	vendor_id
	,product_id
	,original_price
	,row_number() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max

	FROM vendor_inventory
) 
where rn_max = 1

UNION  -- union returned 5 rows...UNION all returned 6 rows (vendor #4 duplicated)

SELECT *
FROM 
(
	SELECT DISTINCT
	vendor_id
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min

	FROM vendor_inventory
) 
where rn_min = 1