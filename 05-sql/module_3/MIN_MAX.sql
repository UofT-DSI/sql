--max / min

SELECT product_name, MAX(cost_to_customer_per_qty)

FROM customer_purchases AS cp
JOIN product AS p
	ON p.product_id = cp.product_id

--GROUP BY product_name

SELECT product_name, MIN(cost_to_customer_per_qty)

FROM customer_purchases AS cp
JOIN product AS p
	ON p.product_id = cp.product_id

--GROUP BY product_name


