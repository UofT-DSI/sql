/* MODULE 5 */
/* VIEW */

/* 1. Create a vendor daily sales view */
DROP VIEW IF EXISTS vendor_daily_sales;
CREATE VIEW IF NOT EXISTS vendor_daily_sales AS 

	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name 
	,SUM(quantity*cost_to_customer_per_qty) as sales
	
	
	FROM market_date_info md
	INNER JOIN customer_purchases cp
		ON md.market_date = cp.market_date
	INNER JOIN vendor v
		ON cp.vendor_id = v.vendor_id
		
	GROUP BY cp.market_date, v.vendor_id
	
	
	

