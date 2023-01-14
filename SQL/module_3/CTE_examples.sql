--CTE

WITH vendor_daily_sales AS (
	SELECT
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity * cost_to_customer_per_qty) AS sales

	FROM customer_purchases as cp
	INNER JOIN market_date_info as md
		ON cp.market_date = md.market_date
	INNER JOIN vendor as v
		ON cp.vendor_id = v.vendor_id
		
	GROUP BY cp.market_date, v.vendor_id
)

SELECT 
market_year
,market_week
,SUM(sales) AS weekly_sales

FROM vendor_daily_sales
GROUP BY 
market_year
,market_week