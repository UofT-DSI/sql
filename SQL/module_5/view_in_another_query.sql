--USING A VIEW IN ANOTHER QUERY
SELECT 
market_year
,market_week
,SUM(sales) AS weekly_sales

FROM todays_sales  -- the view!
GROUP BY 
market_year
,market_week