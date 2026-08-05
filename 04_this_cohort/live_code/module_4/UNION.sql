/* MODULE 4 */
/* UNION */

/* 1. Find the most and least expensive product by vendor with UNION (and row_number!) */

--outer query
SELECT 
vendor_id
,original_price
--,'Max' as max_or_min
,rn_max as [row_number]

FROM (
--inner query 
	SELECT vendor_id
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	
	FROM vendor_inventory
)

WHERE rn_max = 1

UNION -- union returned 5 rows, UNION ALL returned 6 rows because vendor #4 is duplicated

SELECT 
vendor_id
,original_price
--,'Min' as max_or_min
,rn_min 

FROM (
--inner query 
	SELECT vendor_id
	,product_id
	,original_price
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	
	FROM vendor_inventory
)

WHERE rn_min = 1



--------------------------------------------------------------------------------------------------------------------------------------------
