-- subqueries: JOIN

-- "whats the single item that has been bought in the greatest quantity"

SELECT product_name, max(max_quantity)

FROM product p 
INNER JOIN (
		SELECT product_id, max(quantity) as max_quantity

		FROM customer_purchases
		GROUP by product_id
) x ON p.product_id = x.product_id;


--simple subquery in a FROM statement
SELECT DISTINCT inflation, product_id

FROM (
	SELECT product_id, cost_to_customer_per_qty
	,CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
		ELSE cost_to_customer_per_qty END as inflation

	FROM customer_purchases
) 