/* MODULE 3 */
/* Date functions */


/* 1. now */
SELECT DISTINCT
DATE('now') as [now]
,DATETIME('now') as [now]


/* 2. strftime */
,strftime('%Y/%m','now') as year_month
,strftime('%Y-%m-%d','now', '+50 days') as the_future
,market_date
,strftime('%m-%d-%Y', market_date,'+50 days','-1 year') as the_past

FROM market_date_info;


/* 3. adding dates, e.g. last date of the month */
SELECT DISTINCT
market_date
,DATE(market_date, 'start of month','-1 day') as end_of_prev_month
,DATE(market_date,'start of month') as start_of_month

FROM market_date_info;


/* 4. difference between dates, 
 a. number of days between now and each market_date
 b. number of YEARS between now and market_date
 c. number of HOURS bewtween now and market_date
 */
 
 SELECT market_date
 ,julianday('now') - julianday(market_date) as datesbetweenmktdate
 ,(julianday('now') - julianday(market_date)) / 365.25 as yearsbetweenmktdate
 ,(julianday('now') - julianday(market_date))*24 as hoursbetweenmktdate
 
 FROM market_date_info
 
