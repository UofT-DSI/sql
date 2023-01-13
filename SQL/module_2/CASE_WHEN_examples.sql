--CASE

/*
SELECT *
,CASE 
	WHEN customer_zip = '22801'
		THEN 'Texas'
	WHEN customer_zip = '22802'
		THEN 'New Mexico'
	ELSE 'Colorado'
	END AS state
FROM customer
*/

/*
SELECT *
,CASE WHEN customer_id < 10 
	THEN 'VIP'
	ELSE customer_id * 100
END AS weird_column
FROM customer
*/

/*
SELECT 
market_date
,market_day
,market_week
,market_min_temp AS orig_market_min_temp

,CASE WHEN market_min_temp IS NULL
	THEN 20
	ELSE market_min_temp
	END AS new_market_min_temp

FROM market_date_info

*/

SELECT 
product_id
,vendor_id
,market_date
,customer_id
,quantity
,cost_to_customer_per_qty
,quantity * cost_to_customer_per_qty  AS price
,CASE WHEN quantity < 1 THEN quantity * cost_to_customer_per_qty * 1.5 
	WHEN quantity < .5 THEN quantity * cost_to_customer_per_qty * 2.5
	ELSE quantity * cost_to_customer_per_qty END as bigger_price
,transaction_time

FROM customer_purchases

WHERE 
	CASE WHEN quantity < 1 THEN quantity * cost_to_customer_per_qty * 1.5 
		WHEN quantity < .5 THEN quantity * cost_to_customer_per_qty * 2.5
		ELSE quantity * cost_to_customer_per_qty END < 20