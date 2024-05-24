--HAVING

SELECT customer_id, market_date
,SUM(quantity*cost_to_customer_per_qty) AS cost

FROM customer_purchases as cp

WHERE customer_id BETWEEN 1 AND 3
--AND market_date = '2019-08-03'
AND product_id = 8


GROUP BY customer_id, market_date

HAVING cost > 10