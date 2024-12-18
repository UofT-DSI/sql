--UNION/UNION ALL
--most and least expensive product by vendor with a union


SELECT vendor_id, product_id,original_price, rn_max AS [row_number] --renaming because of the union
FROM (
	SELECT DISTINCT
	vendor_id, product_id, original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	FROM vendor_inventory
) x
WHERE rn_max = 1

UNION -- union returned 5 rows? 
--UNION ALL -- returned 6 rows inlcuding vendor #4 who was a duplicate

SELECT * FROM (
	SELECT DISTINCT
	vendor_id, product_id, original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	FROM vendor_inventory
) x
WHERE rn_min = 1