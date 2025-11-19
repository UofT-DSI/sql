/* MODULE 3 */
/* Date functions */


/* 1. now */
SELECT DISTINCT
DATE('now') as [now]
,DATETIME() as [right_now]
,datetime('now','localtime') as [right_now_timezone]

/* 2. strftime */
,strftime('%Y-%m','now') as this_year_this_month
,strftime('%Y/%m/%d', '2025-08-10','+50 days') as the_future
,market_date
,strftime('%m-%d-%Y', market_date, '+30 days','-1 year') as the_past

/* 3. adding dates, e.g. last date of the month */
-- last date of the month
,DATE(market_date,'start of month','-1 day') as end_of_previous_month
,DATE(market_date, 'start of month','-1 day','start of month') as start_of_previous_month


/* 4. difference between dates, 
 a. number of days between now and each market_date
 b. number of YEARS between now and market_date
 c. number of HOURS bewtween now and market_date
 */
 ,market_date
 ,julianday('now') - julianday(market_date) as now_md_dd
 ,(julianday('now') - julianday(market_date)) / 365.25 as now_md_dd_yrs
 ,(julianday('now') - julianday(market_date)) * 24 as now_md_dd_hours

 FROM market_date_info
 
 