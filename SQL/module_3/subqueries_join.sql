-- subqueries

-- join type
-- "whats the single item that has been purchased in the greatest quantity"
SELECT p.product_id, max(max_quantity)

FROM product p
INNER JOIN (

			SELECT 
			cp.customer_id, product_id, max(quantity) AS max_quantity

			FROM customer_purchases as cp
			GROUP BY cp.customer_id, product_id
			
		) x ON p.product_id = x.product_id
		
--(not the same as)		
SELECT product_id,
max(quantity)

FROM customer_purchases as cp
GROUP BY product_id