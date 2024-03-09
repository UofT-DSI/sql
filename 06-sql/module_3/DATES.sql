-- DATES

SELECT DISTINCT
--now
DATETIME('now')
,DATE('now')
,TIME('now')

--STRFTIME
,strftime('%Y %m', '1970-01-01')
,strftime('%Y-%m-%d', '2024-02-27','+50 days') as the_future
,market_date
,strftime('%Y-%m-%d', market_date,'-50 days','-1 year') as the_future

-- DATEADD
,strftime('%Y-%m-%d', '2024-01-27','start of month','-1 day') as last_day_of_last_month

--DATEDIFF equiv
,STRFTIME('%m','2024-12-21') - STRFTIME('%m','now') -- months until december -- caution, can mislead
,CAST(((JULIANDAY('now') - JULIANDAY(market_date)) / 365.25) AS INT) -- number of years between now and marketdate
,((JULIANDAY('now') - JULIANDAY(market_date)) * 24) -- number of hours between now and marketdate
FROM market_date_info