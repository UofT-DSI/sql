--UNION/UNIONALL

--most and least expensive product by vendor with a UNION


SELECT vendor_id, product_id, original_price, rn_min as [row_number] FROM 
	(
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	
	FROM vendor_inventory
	) x
	
where rn_min = 1
	
UNION -- union returned 5 rows, union all 6 rows (vendor 4 duplicate)

SELECT * FROM 
	(
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	
	FROM vendor_inventory
	) x
	
where rn_max = 1
