/* MODULE 4 */
/* Windowed functions: row_number */


/* 1. What product is the highest price per vendor */
--outer query
SELECT x.*
,product_name

FROM 

-- inner query 
(
	SELECT 
	vendor_id,
	product_id,
	original_price,
	market_date,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank
	--if we add product_id we could track price changes over time
	,ROW_NUMBER() OVER(PARTITION BY vendor_id, product_id ORDER BY original_price DESC) as price_rank_time
	FROM vendor_inventory
) x
INNER JOIN product p 
	ON x.product_id = p.product_id

WHERE x.price_rank = 1

/* See how this varies from using max due to the group by 
SELECT vendor_id,
--product_id,
MAX(original_price)

FROM vendor_inventory
GROUP BY vendor_id--,product_id

*/



--------------------------------------------------------------------------------------------------------------------------------------------
