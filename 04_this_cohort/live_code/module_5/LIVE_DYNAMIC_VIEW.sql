--VIEW
-- THIS ONLY WORKS IF YOU HAVE THE PROPER STEPS
-- IMPORT as csv 
-- ?? update the market date info table to also have todays date!
-- UPDATING THE NEW DATA TO "TODAY" in the where statement


DROP VIEW IF EXISTS vendor_daily_sales;
CREATE VIEW IF NOT EXISTS vendor_daily_sales AS
	
	SELECT 
	md.market_date
	,market_day
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) as sales
	
	-- want to update the VIEW
	-- need to bring in the new data 
	-- new data is called new_customer_purchases
	--but we want the old data too!
	--....use a union to combine old and new
	
	FROM market_date_info md
	
	INNER JOIN (
		SELECT * FROM 
		customer_purchases 
		UNION 
		SELECT * FROM 
		new_customer_purchases ) as cp
			ON md.market_date = cp.market_date
	INNER JOIN vendor v
		ON v.vendor_id = cp.vendor_id
		
	-- we want TODAYS data only
	WHERE md.market_date = date('now')
		
	GROUP BY cp.market_date, v.vendor_id
	