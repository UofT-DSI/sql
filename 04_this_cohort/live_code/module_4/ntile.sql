--ntile (4,5,100)

SELECT * 
,NTILE(4) OVER( PARTITION BY vendor_name ORDER BY sales ASC) as quartile
,NTILE(5) OVER( PARTITION BY vendor_name ORDER BY sales ASC) as quintile
,NTILE(100) OVER( PARTITION BY vendor_name ORDER BY sales ASC) as percentile

FROM (


		SELECT md.market_date
			,market_day
			,market_week
			,market_year
			,vendor_name
			,sum(quantity*cost_to_customer_per_qty) AS sales
			
			FROM market_date_info md
			JOIN customer_purchases cp
				on md.market_date = cp.market_date
			JOIN vendor v 
				on cp.vendor_id = v.vendor_id
				
			GROUP BY md.market_date, v.vendor_id

) x