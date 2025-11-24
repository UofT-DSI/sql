/* MODULE 4 */
/* UNION */

/* 1. Find the most and least expensive product by vendor with UNION (and row_number!) */


SELECT  
vendor_id
,product_id
,original_price
,rn_max as [row_number]

FROM (

	SELECT DISTINCT
	vendor_id,
	product_id,
	original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	
	FROM vendor_inventory

)
where rn_max = 1

UNION  -- UNION, 5 rows; duplicate value for vendor_id 4 product_id 16, UNION ALL returned 6 rows with the duplicate

SELECT  
vendor_id
,product_id
,original_price
,rn_min

FROM (

	SELECT DISTINCT
	vendor_id,
	product_id,
	original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	
	FROM vendor_inventory

)
where rn_min = 1



