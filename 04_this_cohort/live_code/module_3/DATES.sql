-- dates

--now

SELECT DISTINCT
DATE('now') as [now]
,DATETIME() as [rightnow]

--strftime
,strftime('%Y/%m','now')
,strftime('%Y-%m-%d', '2025-04-01','+50 days') as the_future
,market_date
,strftime('%m-%d-%Y', market_date, '+50 days', '-1 year') as the_past

--dateadd
--last date of LAST month
,DATE(market_date,'start of month','-1 day') as end_of_prev_month

--datediff "equiv"
,market_date
,julianday('now') - julianday(market_date) -- number of days between now and each market_date
,(julianday('now') - julianday(market_date)) / 365.25    -- number of YEARS between now and market_date
,(julianday('now') - julianday(market_date)) * 24 -- number of HOURS between now and each market_date


FROM market_date_info

