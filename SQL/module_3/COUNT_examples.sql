--COUNT

/* 
SELECT COUNT(*)
FROM customer_purchases

*/

/*
SELECT COUNT(market_date)
,customer_id

FROM customer_purchases
GROUP BY customer_id
*/

/*
SELECT COUNT(DISTINCT market_date), COUNT(market_date)
,customer_id

FROM customer_purchases
GROUP BY customer_id
*/

SELECT COUNT(market_date)
,customer_first_name
,vendor_name

FROM customer_purchases cp
JOIN customer c ON c.customer_id = cp.customer_id
JOIN vendor v ON v.vendor_id = cp.vendor_id
GROUP BY customer_first_name, vendor_name