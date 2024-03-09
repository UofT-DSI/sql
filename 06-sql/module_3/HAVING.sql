-- HAVING


SELECT customer_id, market_date,

SUM(quantity*cost_to_customer_per_qty) AS cost

FROM customer_purchases as cp
WHERE customer_id = 1
--AND cost < 10
GROUP BY customer_id,market_date

HAVING cost < 10


-- WHERE beforehand
SELECT --customer_id,

SUM(quantity*cost_to_customer_per_qty) AS cost

FROM customer_purchases as cp
WHERE customer_id IN (1,2,3)

--GROUP BY customer_id