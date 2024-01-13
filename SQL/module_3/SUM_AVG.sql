-- SUM & AVG

/*
SELECT customer_id
--,quantity * cost_to_customer_per_qty as total_cost
,sum(quantity * cost_to_customer_per_qty) as cost_per_customer
FROM customer_purchases

GROUP BY customer_id
*/

/*
SELECT  customer_first_name, customer_last_name, market_date
--,quantity * cost_to_customer_per_qty as total_cost
,sum(quantity * cost_to_customer_per_qty) as cost_per_customer_per_date
FROM customer_purchases cp
INNER JOIN customer c
	ON c.customer_id = cp.customer_id

WHERE market_date BETWEEN '2019-01-01' AND '2019-12-31'
	
GROUP BY  c.customer_id,market_date
ORDER BY market_date
*/

SELECT 
market_season,
avg(market_max_temp)

FROM market_date_info
GROUP BY market_season
