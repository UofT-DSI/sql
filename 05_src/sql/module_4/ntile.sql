
--ntile (4,5,100)

-- bucket daily sales


SELECT *
,NTILE(4) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as quartile
,NTILE(5) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as quintile
,NTILE(100) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as percentile
		
FROM (

	SELECT
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) AS sales
	
	
	FROM customer_purchases cp -- gets sales details
	JOIN market_date_info as md -- gets all the date columns
		ON cp.market_date = md.market_date
	JOIN vendor v -- gets the vendor name
		ON v.vendor_id = cp.vendor_id
	
	GROUP BY md.market_date, v.vendor_id


	) x
	
