-- using a view in another QUERY

SELECT market_year, market_week, vendor_name, sum(sales)

FROM vendor_daily_sales

GROUP BY market_year, market_week, vendor_name