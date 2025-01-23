--CTEs

--calculate sales per vendor per day
WITH vendor_daily_sales AS (
SELECT 
md.market_date
,market_day
,market_week
,market_year
,vendor_name
,sum(quantity*cost_to_customer_per_qty) as sales

FROM customer_purchases cp
INNER JOIN vendor v
	ON cp.vendor_id = v.vendor_id
INNER JOIN market_date_info md
	ON cp.market_date = md.market_date

GROUP BY md.market_date, v.vendor_id
), -- this comma for the next cte

-- not doing anything, but still makes the 2nd cte, don't use with again
another_cte AS
(
select * from product
)

--re-aggregate the daily sales within each market_week for each vendor
SELECT 
market_year
,market_week
,vendor_name
,sum(sales)

FROM vendor_daily_sales
GROUP BY market_year, market_week, vendor_name