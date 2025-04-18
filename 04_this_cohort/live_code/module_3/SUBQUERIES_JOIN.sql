-- SUBQUERIES: JOIN

-- "what is the single item that has been bought in the greatest quantity?"
SELECT product_name,  max(quantity)

FROM product p
INNER JOIN (
	--inner query
	SELECT product_id, count(quantity) as quantity_purchased
	FROM customer_purchases
	GROUP BY product_id
	
) x ON p.product_id = x.product_id;

-- simple subquery in a FROM statement

SELECT DISTINCT
product_id, inflation
FROM (
	SELECT product_id, cost_to_customer_per_qty,
		CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
			ELSE cost_to_customer_per_qty END as inflation
	FROM customer_purchases
) 
