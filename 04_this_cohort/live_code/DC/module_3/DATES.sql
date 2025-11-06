/* MODULE 3 */
/* Date functions */


/* 1. now */
SELECT DISTINCT
DATE('now') as [now]
,DATETIME('now') [rightnow]
,DATE() as[todaysdate]

/* 2. strftime */
,strftime('%Y/%m','now') as [1]
,strftime('%Y-%m-%d','now','+50 days') as the_future
,market_date 
,strftime('%m-%d-%Y',market_date,'+50 days','-1 year') as the_past

/* 3. adding dates, e.g. last date of the month */
--last date of last month
,DATE(market_date,'start of month','-1 day') as end_of_prev_month


/* 4. difference between dates, 
 a. number of days between now and each market_date
 b. number of YEARS between now and market_date
 c. number of HOURS bewtween now and market_date
 */
 ,market_date
 ,julianday('now') - julianday(market_date) as datesbetweenmktdate -- number of days between now and each market date
,(julianday('now') - julianday(market_date)) / 365.25
,(julianday('now') - julianday(market_date)) * 24
 
 FROM market_date_info