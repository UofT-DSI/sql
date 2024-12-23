--DYNAMIC VIEW
-- THIS ONLY WORKS IF YOU HAVE DONE THE PROPER STEPS FOR IMPORTING! INSERTING A NEW DATE! AND UPDATING THE NEW DATA TO "TODAY"
DROP VIEW IF EXISTS todays_vendor_daily_sales;
CREATE VIEW IF NOT EXISTS todays_vendor_daily_sales AS

	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) as sales
	
	FROM market_date_info md
	INNER JOIN (
		SELECT * FROM customer_purchases 
		UNION
		SELECT * FROM new_customer_purchases) cp
		
		ON md.market_date = cp.market_date
	INNER JOIN vendor v
		ON cp.vendor_id = v.vendor_id
	
	/*PICK ONE OF THE WHERE STATEMENTS!*/
	--WHERE md.market_date = strftime('%Y-%m-%d',DATE('now'),'-1 day')-- today! -- 
	WHERE md.market_date = DATE('now','localtime')
	--WHERE md.market_date = '2024-12-18'
	
	GROUP BY cp.market_date, v.vendor_id