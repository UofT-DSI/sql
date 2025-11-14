SELECT
	c.customer_id,
	c.customer_last_name,
	c.customer_first_name,
	SUM (p.quantity * p.cost_to_customer_per_qty) AS total_spent
FROM customer AS c
JOIN customer_purchases AS p
	ON c.customer_id = p.customer_id
GROUP BY 
	c.customer_id,
	c.customer_last_name,
	c.customer_first_name
HAVING 
	SUM (p.quantity * p.cost_to_customer_per_qty) > 2000
ORDER BY 
	c.customer_last_name,
	c.customer_first_name;
