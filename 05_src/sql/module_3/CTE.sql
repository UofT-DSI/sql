--CTE

-- calculate sales per vendor by day
WITH vendor_daily_sales AS (
	SELECT md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) AS sales
	
	FROM market_date_info as md
	JOIN customer_purchases cp 
		ON md.market_date = cp.market_date
	JOIN vendor v 
		ON cp.vendor_id = v.vendor_id
	
	GROUP by md.market_date, v.vendor_id

)

-- a new one
,a_new_cte AS (select * from product)

-- re-aggregate daily sales within each week for each vendor
SELECT market_year
,market_week
,vendor_name
,sum(sales) AS weekly_sales

FROM vendor_daily_sales

WHERE market_year = 2019
and market_week = 20

GROUP BY market_year,market_week, vendor_name
