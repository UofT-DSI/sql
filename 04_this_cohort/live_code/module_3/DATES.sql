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