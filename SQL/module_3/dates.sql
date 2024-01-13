--DATETIME 

--now
SELECT DATETIME('now'), DATE('now')

--STRFTIME
,strftime('%Y/%m','1970-01-01') 
,strftime('%Y/%m/%d','2022-01-21', +'50 days') AS the_future
,market_date
,strftime('%Y-%m-%d',market_date, '-1 years')
,strftime('%w',market_date)

--dateadds
,DATE('2024-01-12', 'start of month', '-1 day') --start of this month, minus one day = last day of last month
,DATE('2024-01-12', 'start of month') -- start of this month
, DATE('2024-01-12', '+12 day')

--datediffs
,strftime('%H','2024-01-02 00:00:00.000') - strftime('%H','2024-01-01 11:11:11.111') as working--?? requires TIME
,STRFTIME('%m','2024-12-21') - STRFTIME('%m','NOW')
,strftime('%m','2024-11-02') - strftime('%m','2024-01-01')
,market_date
,cast(((julianday('now') - julianday(market_date)) / 365.25) AS INT) 
,(julianday('now') - julianday(market_date)) * 24  -- number of hours between now and market dates
,strftime('%m','2024-06-21') - strftime('%m','NOW')


FROM market_date_info