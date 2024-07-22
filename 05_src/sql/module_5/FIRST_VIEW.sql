-- VIEW
DROP VIEW IF EXISTS vendor_daily_sales;
CREATE VIEW IF NOT EXISTS vendor_daily_sales AS
	
	SELECT
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) AS sales
	
	FROM customer_purchases 
	INNER JOIN market_date_info md
		ON cp.market_date = md.market_date
	INNER JOIN vendor v
		ON cp.vendor_id = v.vendor_id
	
	--WHERE md.market_date = date('now')

	GROUP BY cp.market_date, v.vendor_id