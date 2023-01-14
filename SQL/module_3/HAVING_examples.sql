--HAVING

/*
SELECT customer_id
,SUM(cost_to_customer_per_qty*quantity) AS total_spent

FROM customer_purchases
WHERE product_id IN (8)
GROUP BY customer_id
HAVING total_spent > 500
ORDER BY total_spent DESC
*/

SELECT DISTINCT
customer_first_name,
customer_last_name,
product_name,
SUM(quantity * cost_to_customer_per_qty) as total_cherry_pie_cost

FROM customer_purchases cp
INNER JOIN customer c
	ON c.customer_id = cp.customer_id
INNER JOIN product p
	ON cp.product_id = p.product_id

WHERE p.product_id = 8

GROUP BY customer_first_name,
customer_last_name,
product_name

HAVING total_cherry_pie_cost > 500

ORDER BY total_cherry_pie_cost DESC