--CTE

--calculate sales per vendor per day
WITH vendor_daily_sales AS (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,sum(quantity*cost_to_customer_per_qty) as sales

	FROM customer_purchases cp 
	INNER JOIN vendor v 
		ON v.vendor_id = cp.vendor_id
	INNER JOIN market_date_info md
		ON cp.market_date = md.market_date

	GROUP BY md.market_date,v.vendor_id
)

-- re-aggregate daily sales within each week number for each vendor
SELECT 
market_year,
market_week,
vendor_name,
sum(sales)

FROM vendor_daily_sales
GROUP BY market_year,market_week,vendor_name