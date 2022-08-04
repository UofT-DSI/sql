
SELECT DISTINCT 
--now
DATETIME('now'),

--STRFTIME
STRFTIME('%Y %m', '1970-01-01'),
STRFTIME('%Y-%m-%d', '2022-07-24', '+50 days') AS the_future,
market_date,
STRFTIME('%Y-%m-%d',market_date, '-1 years'),
STRFTIME('%Y-%m-%d',market_date,'weekday 6'),

--DATEADD equiv
STRFTIME('%Y-%m-%d','2022-07-24', 'start of month', '-1 day'),
STRFTIME('%Y-%m-%d','now', 'start of month', '-1 month','-1 day') --last day of two months ago

--DATEDIFF equiv
,STRFTIME('%m','2022-12-21') - STRFTIME('%m','NOW')
,CAST(((JULIANDAY('now') - JULIANDAY(market_date)) / 365.25) AS INT) --number of years between now and marketdate
,((JULIANDAY('now') - JULIANDAY(market_date)) * 24)  --number of hours between now and marketdate


FROM market_date_info
WHERE STRFTIME('%Y',market_date) = '2019'