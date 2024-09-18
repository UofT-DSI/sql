-- dates

--now
SELECT DISTINCT
DATE('now')
,DATETIME()

--strftime
,strftime('%Y-%m','now')
,strftime('%Y-%m-%d','2024-09-16','+50 days') as the_future
,market_date
,strftime('%Y-%m-%d',market_date,'+50 days','-1 year') as the_past

--dateadd
--last day of the month
,strftime('%Y-%m-%d', market_date, 'start of month','-1 day')

--datediff equiv
,market_date
,(julianday('now') - julianday(market_date)) / 365.25 -- number of years between now and marketdate
,julianday('now') - julianday(market_date) -- number of days between now and each marketdate
,(julianday('now') - julianday(market_date)) * 24 -- number of HOURS between now and each marketdate

FROM market_date_info