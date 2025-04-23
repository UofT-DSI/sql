-- SUM & avg

-- how much did a customer spend each day
SELECT 
market_date,
customer_id,
SUM(quantity*cost_to_customer_per_qty) as total_cost

FROM customer_purchases
GROUP BY market_date, customer_id;

--how much does each customer spend on average
SELECT 
customer_first_name,
customer_last_name,
ROUND(AVG(quantity*cost_to_customer_per_qty),2) as avg_cost

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id

GROUP BY c.customer_id