--UNION/UNION ALL
--most and least expensive product by vendor using a UNION

SELECT 
vendor_id,
product_id,
original_price,
rn_max AS [row_number] --renaming because the later query we union will want this neutral name
--,'the max' AS [preserve]
FROM (
	SELECT DISTINCT
	vendor_id
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	
	FROM vendor_inventory
) x
WHERE rn_max = 1

UNION  -- union returned 5 rows
--UNION ALL -- returns 6 rows because vendor 4 is a duplicate

SELECT * 
--,'the min' AS [preserve]
FROM (
	SELECT DISTINCT
	vendor_id
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	
	FROM vendor_inventory
) y
WHERE rn_min = 1
