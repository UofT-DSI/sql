

-- SELECT *,
-- CASE WHEN customer_id = 4 THEN 'Favourite' END AS favouirte_customer
-- 
-- FROM customer
 
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
--LIMIT 10