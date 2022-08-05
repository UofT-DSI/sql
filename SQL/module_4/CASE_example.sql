-- this case statement evaluates the logical expression before adjusting the column output with when statements

SELECT DISTINCT
strftime('%w', market_date),
 CASE strftime('%w', market_date) -- different than normal
  WHEN '0' THEN 'Sunday'
  WHEN '1' THEN 'Monday'
  WHEN '2' THEN 'Tuesday'
  WHEN '3' THEN 'Wednesday'
  WHEN '4' THEN 'Thursday'
  WHEN '5' THEN 'Friday'
  ELSE 'Saturday' END AS weekday
  
 FROM customer_purchases