-- HAVING

-- how much did a customer spend on each day
SELECT 
market_date,
customer_id,
SUM(quantity*cost_to_customer_per_qty) as total_cost

FROM customer_purchases
WHERE customer_id BETWEEN 1 AND 5 -- filtering the non-aggregated values
OR customer_id = 10
GROUP BY market_date, customer_id
HAVING total_cost > 50; -- filtering the aggregated values

-- how many products were bought

SELECT count(product_id) as num_of_prod, product_id

FROM customer_purchases
WHERE product_id <= 8
GROUP BY product_id
HAVING count(product_id) BETWEEN 300 AND 500

