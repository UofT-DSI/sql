-- dates

-- now

SELECT DISTINCT
DATE('now') as [now]
,DATETIME() as [right_now]

--strftime
,strftime('%Y/%m','now') as this_year_month
,strftime('%Y-%m-%d', '2025-08-10', '+50 days') as the_future
,market_date
,strftime('%m-%d-%Y',market_date, '+50 days', '-1 year') as the_past

--dateadd
--last date of the month
,DATE(market_date,'start of month','-1 day','start of month') as start_of_prev_month
,DATE(market_date,'start of month','-1 day') as end_of_prev_month


-- datediff "equiv"
,market_date
,julianday('now') - julianday(market_date) as now_md_dd-- number of days between now and each market_date
,(julianday('now') - julianday(market_date)) / 365.25 as now_md_dd_yrs -- number of YEARS between now and market_date
,(julianday('now') - julianday(market_date)) * 24 as now_md_dd_hours -- number of HOURS bewtween now and market_date

FROM market_date_info


--IFNULL and coalesce & NULLIF

SELECT *
,IFNULL(product_size,'Unknown') 

--replace with another COLUMN
,IFNULL(product_size, product_qty_type)
,coalesce(product_size, product_qty_type)
,coalesce(product_size,product_qty_type,'missing') -- if the first value is null, then the second value, if that is null, then the third value (missing) 

,IFNULL(IFNULL(product_size, product_qty_type),'missing') -- same as above but with two ifnulls

FROM product;

SELECT *
,coalesce(product_size,'Unknown') -- we aren't successfully handling the blank value
--nullif
,NULLIF(product_size,'') -- find the values in product_size that "blanks" and set them to null
,coalesce(NULLIF(product_size,''),'Unknown')
,coalesce(NULLIF(TRIM(product_size),''),'Unknown') -- a trimmed blank so all white space becomes blank '     ' = ''

FROM product

WHERE NULLIF(product_size,'') IS NULL -- capturing BOTH nulls and blanks at the same time!

--ROW_NUMBER 
--what product is the highest price per vendor

--outer QUERY

SELECT x.*,product_name

FROM (
--inner QUERY
	SELECT 
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank

	FROM vendor_inventory
) x
INNER JOIN product p 
	ON x.product_id = p.product_id

WHERE price_rank = 1;

--highest single purchase in a day PER customer 

SELECT * 
FROM (
	SELECT 
	customer_id
	,product_id
	,market_date
	,quantity
	,quantity*cost_to_customer_per_qty as cost
	,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY quantity*cost_to_customer_per_qty DESC) as sales_rank

	FROM customer_purchases
) x



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
--FULL OUTER JOIN WITH A UNION
--two stores, determining which customes they have in stock

DROP TABLE IF EXISTS temp.store1; 
CREATE TEMP TABLE IF NOT EXISTS temp.store1
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store1
VALUES("tiger",6),
        ("elephant",2),
        ("princess", 4);


DROP TABLE IF EXISTS temp.store2;
CREATE TEMP TABLE IF NOT EXISTS temp.store2
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store2
VALUES("tiger",2),
	("dancer",7),
	("superhero", 5);
	



