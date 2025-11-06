/* MODULE 4 */
/* Windowed functions: row_number */


/* 1. What product is the highest price per vendor */
--outer query 
SELECT x.*
,product_name

-- inner query 
FROM 
(
	SELECT 
	vendor_id
	,product_id
	,original_price
	,market_date
	,ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank
	-- if we add product_id we could potentially track the time where original_price changed
	,ROW_NUMBER() OVER(PARTITION BY vendor_id,product_id ORDER BY original_price DESC)
	
	FROM vendor_inventory
) x
INNER JOIN product p
	ON x.product_id = p.product_id

WHERE x.price_rank = 1;

/* See how this varies from using max due to the group by 
SELECT vendor_id,
--product_id,
MAX(original_price)

FROM vendor_inventory
GROUP BY vendor_id--,product_id

*/
 -- highest single purchase in a day per customer
 
 SELECT * 
 
 FROM (
	 
	 SELECT
	 customer_id
	 ,product_id
	 ,market_date
	 ,quantity
	 ,quantity*cost_to_customer_per_qty as cost
	 ,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY quantity*cost_to_customer_per_qty DESC) as sales_rank
	 
	 FROM customer_purchases
) x
WHERE x.sales_rank = 1

ORDER BY cost desc