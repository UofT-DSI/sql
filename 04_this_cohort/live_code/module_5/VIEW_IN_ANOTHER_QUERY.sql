-- using a view in another query
SELECT 
market_year
,market_week
,vendor_name
,SUM(sales) as weekly_sales

FROM vendor_daily_sales

GROUP BY market_year
,market_week
,vendor_name