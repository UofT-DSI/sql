--dates

SELECT DISTINCT
--now
DATE('now')
,TIME()
,DATETIME()

--strftime
,strftime('%Y-%m','now')
,strftime('%Y-%m-%d', '2024-05-20', '+50 days') as the_future
,market_date
,strftime('%Y/%m/%d',market_date,'+50 days','-1 year')

--dateadd
-- last day of last month
,strftime('%Y-%m-%d', market_date, 'start of month', '-1 day')

--datediff equiv
,market_date
,CAST(((julianday('now') - julianday(market_date)) / 365.25) as int) -- number of years between now and marketdate
,julianday('now') - julianday(market_date) -- number of days between now and each marketdate
,(julianday('now') - julianday(market_date))  * 24 -- number of HOURS between now and each marketdate

FROM market_date_info