--using a view in another query

SELECT 
market_year
,market_week
,sum(sales) AS weekly_sales

FROM vendor_daily_sales -- the view

GROUP BY market_year, market_week