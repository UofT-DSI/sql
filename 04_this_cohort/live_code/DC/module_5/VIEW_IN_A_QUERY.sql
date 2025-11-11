/* MODULE 5 */
/* VIEW in another query */

/* 1. Transform the daily sales view into a sales by vendor per week result */

SELECT 
market_year
,market_week
,vendor_name
,SUM(sales)


FROM vendor_daily_sales

GROUP BY 
market_year
,market_week
,vendor_name


