/* MODULE 3 */
/* Subquery WHERE */


/* 1. How much did each customer spend at each vendor for each day at the market WHEN IT RAINS */
SELECT 
market_date
,customer_id
,vendor_id
,SUM(quantity*cost_per_quantity) as total_spend

FROM customer_purchases

WHERE market_date IN
(
	SELECT market_date
	FROM market_date_info
	WHERE market_rain_flag = 1
)

 GROUP BY market_date
 ,customer_id
 ,vendor_id;

/* 2. What is the name of the vendor who sells pie */

SELECT DISTINCT vendor_owner_first_name, vendor_name -- coming from vendor table

FROM customer_purchases as cp  -- something that was sold
INNER JOIN vendor as v
	on cp.vendor_id = v.vendor_id

WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'

);
--------------------------------------------------------------------------------------------------------------------------------------------
