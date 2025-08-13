--CTE

--calculate sales per vendor per day

WITH vendor_daily_sales AS (
	SELECT 
	md.market_date,
	market_day,
	market_week,
	market_year,
	vendor_name,
	SUM(quantity*cost_to_customer_per_qty) as sales
	
	
	FROM customer_purchases cp
	INNER JOIN market_date_info md -- get the market_day, market_week, market_year
		ON cp.market_date = md.market_date
	INNER JOIN vendor v
		ON v.vendor_id = cp.vendor_id
	
	GROUP BY md.market_date, v.vendor_id
	
) , -- if we want another CTE, add a comma, but not another with

new_customer AS
(
	SELECT * FROM customer
),

-- re-aggregate the daily sales for each WEEK instead
SELECT 
market_year,
market_week,
vendor_name,
SUM(sales) as weekly_sales

FROM vendor_daily_sales
GROUP by market_year, market_week, vendor_name
