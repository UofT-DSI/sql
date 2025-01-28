-- NTILE (4,5,100)

--day sales
SELECT * FROM 
(
	SELECT * 
	,NTILE(4) OVER(PARTITION BY vendor_name ORDER BY sales asc) as quartile
	,NTILE(5) OVER(PARTITION BY vendor_name ORDER BY sales asc) as quintile
	,NTILE(100) OVER(PARTITION BY vendor_name ORDER BY sales asc) as percentile



	FROM (
		SELECT 
		md.market_date
		,market_week
		,market_year
		,vendor_name
		,sum(quantity*cost_to_customer_per_qty) as sales

		FROM market_date_info as md
		JOIN customer_purchases cp 
			on md.market_date = cp.market_date
		JOIN vendor v
			on cp.vendor_id = v.vendor_id
			
		GROUP BY md.market_date, v.vendor_id
	) x 
) y
WHERE percentile IN (98,99,100) -- best 3
OR percentile IN (1,2,3) -- worst 3
