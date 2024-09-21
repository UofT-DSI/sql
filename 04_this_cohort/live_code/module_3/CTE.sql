--CTEs

--calculate sales per vendor per day

WITH vendor_daily_sales AS (
	SELECT md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,sum(quantity*cost_to_customer_per_qty) AS sales
	
	FROM market_date_info md
	JOIN customer_purchases cp
		on md.market_date = cp.market_date
	JOIN vendor v 
		on cp.vendor_id = v.vendor_id
		
	GROUP BY md.market_date, v.vendor_id
)

--another cte
,a_new_cte AS (SELECT * FROM product)

--re-aggregate daily sales within each week for each vendor
SELECT market_year
,market_week
,vendor_name
,sum(sales) as weekly_sales

FROM vendor_daily_sales
GROUP BY market_year, market_week, vendor_name;

