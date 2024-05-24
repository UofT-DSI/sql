--SUM & AVG

/*
SELECT market_date, customer_id,
SUM(quantity * cost_to_customer_per_qty) AS cost

FROM customer_purchases
GROUP BY market_date, customer_id
*/

SELECT customer_first_name, customer_last_name,

avg(quantity * cost_to_customer_per_qty) as avg_cost

FROM customer_purchases cp
INNER JOIN customer c
	ON c.customer_id = cp.customer_id

GROUP BY customer_first_name, customer_last_name
ORDER BY c.customer_id ASC, avg_cost DESC