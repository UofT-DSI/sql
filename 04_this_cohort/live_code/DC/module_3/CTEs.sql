/* MODULE 3 */
/* Common Table Expression (CTE) */


/* 1. Calculate sales per vendor per day */
WITH vendor_daily_sales AS (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) as sales

	FROM customer_purchases cp
	INNER JOIN vendor v -- we want the vendor_name
		ON v.vendor_id = cp.vendor_id
	INNER JOIN market_date_info md -- all the date columns
		ON cp.market_date = md.market_date

	GROUP BY md.market_date, v.vendor_id

)


/* ... re-aggregate the daily sales for each WEEK instead now  */

SELECT 
market_year
,market_week
,vendor_name
,SUM(sales) as sales

FROM vendor_daily_sales
GROUP BY market_year,market_week, vendor_name



