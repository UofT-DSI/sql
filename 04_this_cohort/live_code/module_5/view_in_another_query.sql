--using a view in another QUERY

-- sales by vendor per week
SELECT 
market_year
,market_week
,vendor_name
,SUM(sales)

FROM vendor_daily_sales

GROUP BY 
market_year
,market_week
,vendor_name