--NTILE (4,5,100?)

--daily sales
SELECT *
,NTILE(4) OVER(PARTITION by vendor_name ORDER by sales asc) as quartile
,NTILE(5) OVER(PARTITION by vendor_name ORDER by sales asc) as quintile
,NTILE(100) OVER(PARTITION by vendor_name ORDER by sales asc) as percentile

FROM (
	SELECT 
	md.market_date,
	market_week,
	market_year,
	vendor_name,
	sum(quantity*cost_to_customer_per_qty) as sales

	FROM market_date_info md
	JOIN customer_purchases cp
		on md.market_date = cp.market_date
	JOIN vendor v
		on cp.vendor_id = v.vendor_id
		
	GROUP BY md.market_date, v.vendor_id
) x