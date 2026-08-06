/* MODULE 5 */
/* DYNAMIC VIEW */

/* 1. Create todays vendor daily sales view */
DROP VIEW IF EXISTS todays_vendor_daily_sales;
CREATE VIEW IF NOT EXISTS todays_vendor_daily_sales AS

	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name 
	,SUM(quantity*cost_per_quantity) as sales
	
	FROM market_date_info md
	INNER JOIN (
			SELECT * FROM 
			customer_purchases 
			UNION
			SELECT * FROM 
			new_customer_purchases) cp
		ON md.market_date = cp.market_date
		
	INNER JOIN vendor v
		ON cp.vendor_id = v.vendor_id
	
	WHERE cp.market_date = DATE('now','localtime')
		
	GROUP BY cp.market_date, v.vendor_id;



/* spoilers below */





-- THIS ONLY WORKS IF YOU HAVE DONE THE PROPER STEPS FOR IMPORTING 
-- 1) update new_customer_purchases to today
-- 2) add the union 
-- 3) add the where statement
-- 4) update the market_date_info to include today





--------------------------------------------------------------------------------------------------------------------------------------------
