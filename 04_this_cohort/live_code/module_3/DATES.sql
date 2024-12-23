--dates

SELECT DISTINCT 
DATE('now'),
DATETIME('now')

--strftime
,strftime('%Y/%m','now')
,strftime('%Y/%m/%d','now','+50 days') as the_future
,market_date
,strftime('%Y-%m-%d',market_date,'+50 days','-1 year') as the_past
,strftime('%Y-%m-%d','now','-2 year') two_year_ago
,strftime('%Y-%m-%d','now','-1 year') as one_year_ago

--dateadd
--last day of the month
,strftime('%Y-%m-%d',market_date,'start of month','-1 day')
,strftime('%Y-%m-%d',market_date,'start of month','+3 months') as three_months_forward

--datediff
,market_date
,julianday('now')
,julianday('now') - julianday(market_date) -- number of days between now and each market date
,(julianday('now') - julianday(market_date))  / 365.25 -- number of years between now and each market date
,(julianday('now') - julianday(market_date))  * 24 -- number of HOURS between now and each market date

FROM market_date_info