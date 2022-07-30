WITH sales_by_day_vendor AS (

SELECT 
cp.market_date
,market_day
,market_week
,market_year
,cp.vendor_id
,vendor_name
,vendor_type
,SUM(quantity * cost_to_customer_per_qty) AS sales

FROM customer_purchases cp
INNER JOIN market_date_info md
	ON cp.market_date = md.market_date
INNER JOIN vendor v
	ON cp.vendor_id = v.vendor_id

GROUP BY cp.market_date, v.vendor_id	
	
)

SELECT 
market_year
,market_week
,SUM(sales) AS weekly_sales

FROM sales_by_day_vendor
GROUP BY market_year, market_week