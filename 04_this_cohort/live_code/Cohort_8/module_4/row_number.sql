/* MODULE 4 */
/* Windowed functions: row_number */


/* 1. What product is the highest price per vendor */
SELECT 
x.*, product_name

FROM (
	--inner QUERY
	SELECT 
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank

	FROM vendor_inventory
) x
INNER JOIN product p
	ON x.product_id = p.product_id

WHERE price_rank = 1


/* See how this varies from using max due to the group by 
SELECT vendor_id,
--product_id,
MAX(original_price)

FROM vendor_inventory
GROUP BY vendor_id--,product_id

*/

