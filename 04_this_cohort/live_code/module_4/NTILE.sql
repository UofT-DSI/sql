--ntile 4, 5, 100

--make quartiles, qunitiles, percentiles

SELECT * 
--,NTILE(4) OVER (PARTITION BY vendor_name ORDER BY sales) as quartiles
--,NTILE(5) OVER (PARTITION BY vendor_name ORDER BY sales) as quantiles
--,NTILE(100) OVER (PARTITION BY vendor_name ORDER BY sales) as percentile

,NTILE(4) OVER (PARTITION BY vendor_name,product_id ORDER BY sales) 

FROM (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,vendor_name
	,product_id
	,sum(quantity*cost_to_customer_per_qty) as sales

	FROM market_date_info md
	JOIN customer_purchases cp
		ON md.market_date = cp.market_date
	JOIN vendor v
		ON cp.vendor_id = v.vendor_id
		
	GROUP By md.market_date, v.vendor_id
) x