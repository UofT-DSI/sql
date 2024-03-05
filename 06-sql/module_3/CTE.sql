-- CTE

WITH vendor_daily_sales AS (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) AS sales

	FROM customer_purchases AS cp
	JOIN market_date_info AS md
		ON cp.market_date = md.market_date
	JOIN vendor AS v
		ON v.vendor_id = cp.vendor_id
		
	GROUP BY cp.market_date, v.vendor_id
)

,a_new_CTE AS (
SELECT * FROM booth
)

-- now let's find out their sales per week:
SELECT 
market_year
,market_week
,vendor_name
,SUM(sales) AS weekly_sales

FROM vendor_daily_sales
WHERE  1=1
--AND market_year = 2019
--AND market_week = 22


GROUP BY market_year
,market_week
,vendor_name