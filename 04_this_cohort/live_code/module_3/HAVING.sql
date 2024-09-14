--HAVING

-- how much did a customer spend on each day
SELECT 
customer_id
,market_date
,SUM(quantity*cost_to_customer_per_qty) as cost

FROM customer_purchases as cp
WHERE customer_id BETWEEN 1 AND 3 -- filters BEFORE the aggregation, only customers 1 2 3 are being aggregated
--AND cost > 50 -- not allowed , has to be in HAVING!

GROUP BY customer_id
,market_date
HAVING cost > 50 -- filters AFTER based on the aggregation