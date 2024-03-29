--most and least expensive product by vendor, with UNION

SELECT * FROM (
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min

	FROM vendor_inventory 
) x
WHERE rn_min = 1

UNION

SELECT * FROM (
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max

	FROM vendor_inventory
) y
WHERE rn_max = 1