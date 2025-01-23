--dates

SELECT 
DATE('now')
,DATETIME('now')

--strftime
,strftime('%Y-%m','now')
,strftime('%Y-%m-%d','now','+30 days') as the_future
,market_date
,strftime('%Y-%m-%d',market_date,'-1 year','+30 days') -- 11 months before the market_date
,strftime('%Y-%m-%d','now','-1 year')

--dateadd
--last day of the month
,strftime('%Y-%m-%d',market_date,'start of month','-1 day')

from market_date_info;

select distinct market_date
--datediff
, julianday('now')
, julianday(market_date)
, julianday('now') - julianday(market_date) -- number of days between now and eaach market_date
, (julianday('now') - julianday(market_date)) / 365.25 -- number of years between now and each market_date
, (julianday('now') - julianday(market_date)) * 24 -- number of hours between now and each market_date

from market_date_info
