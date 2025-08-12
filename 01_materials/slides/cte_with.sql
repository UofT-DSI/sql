--CTE

--calculate sales per vendor per day

WITH vendor_daily_sales AS (
	SELECT 
	md.market_date,
	market_day,
	market_week,
	market_year,
	vendor_name,
	SUM(quantity*cost_to_customer_per_qty) as sales
	
	
	FROM customer_purchases cp
	INNER JOIN market_date_info md -- get the market_day, market_week, market_year
		ON cp.market_date = md.market_date
	INNER JOIN vendor v
		ON v.vendor_id = cp.vendor_id
	
	GROUP BY md.market_date, v.vendor_id
	
) , -- if we want another CTE, add a comma, but not another with

new_customer AS
(
	SELECT * FROM customer
),

-- re-aggregate the daily sales for each WEEK instead
SELECT 
market_year,
market_week,
vendor_name,
SUM(sales) as weekly_sales

FROM vendor_daily_sales
GROUP by market_year, market_week, vendor_name


-- temp tables

-- if a table named new_vendor_inventory exists, delete it, other do NOTHING
DROP TABLE IF EXISTS temp.new_vendor_inventory;

--make the TABLE
CREATE TABLE temp.new_vendor_inventory AS

-- definition of the TABLE
SELECT * 
,original_price * 5 as inflation
FROM vendor_inventory;


-- put the table into another temp table

DROP TABLE IF EXISTS temp.new_new_vendor_inventory;


CREATE TABLE temp.new_new_vendor_inventory AS
SELECT * ,
inflation*2 as super_inflation
FROM temp.new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory






