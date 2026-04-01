/* MODULE 3 */
/* Common Table Expression (CTE) */


/* 1. Calculate sales per vendor per day */
;WITH vendor_daily_sales AS (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) as sales
	
	FROM customer_purchases cp
	INNER JOIN market_date_info as md
		ON cp.market_date = md.market_date
	INNER JOIN vendor as v
		ON cp.vendor_id = v.vendor_id
		
	GROUP BY md.market_date, v.vendor_id
)
--add another CTE
, another_cte AS -- don't use another WITH 
(
select * from product
)


/* ... re-aggregate the daily sales for each WEEK instead now  */
SELECT 
market_year,
market_week,
vendor_name,
SUM(sales) as weekly_sales

FROM vendor_daily_sales

GROUP BY market_year,market_week,vendor_name


--------------------------------------------------------------------------------------------------------------------------------------------
