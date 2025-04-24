-- CTE

-- calculate sales per vendor per day
WITH vendor_daily_sales AS (
	SELECT 
	md.market_date,
	market_day,
	market_week,
	market_year,
	vendor_name,
	SUM(quantity*cost_to_customer_per_qty) as sales

	FROM customer_purchases cp
	INNER JOIN vendor v -- we want the vendor_name 
		ON v.vendor_id = cp.vendor_id
	INNER JOIN market_date_info md -- we want the market_day, market_week, market_year
		ON cp.market_date = md.market_date
		
	GROUP by md.market_date, v.vendor_id
)

-- re-aggregate the daily sales for each WEEK instead

SELECT 
market_year,
market_week,
vendor_name,
sum(sales)

FROM vendor_daily_sales
GROUP BY market_year, market_week, vendor_name