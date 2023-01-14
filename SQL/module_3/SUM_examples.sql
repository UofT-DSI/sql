--SUM

--SELECT CAST('abc' AS INT)

/*
SELECT customer_id
,SUM(cost_to_customer_per_qty*quantity) AS total_spent

FROM customer_purchases
GROUP BY customer_id
ORDER BY total_spent DESC
*/

SELECT vendor_id
,market_date
,AVG(quantity)

FROM vendor_inventory
GROUP BY market_date,vendor_id
