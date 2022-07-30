SELECT p.product_id, MAX(max_quantity)

	FROM product p

	INNER JOIN (
		SELECT cp.customer_id, product_id, MAX(quantity) AS max_quantity

		FROM customer c
		INNER JOIN customer_purchases cp
			ON c.customer_id = cp.customer_id
		
		GROUP BY cp.customer_id, product_id
		
	) x ON p.product_id = x.product_id 
