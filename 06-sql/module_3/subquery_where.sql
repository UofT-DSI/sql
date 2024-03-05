-- subqueries

-- where type

/*
SELECT DISTINCT vendor_name, count(distinct product_id)

FROM vendor_inventory vi
JOIN vendor v
	ON v.vendor_id = vi.vendor_id

WHERE product_id IN (
			SELECT product_id

			FROM product
			WHERE product_name LIKE '%pie%'
		)
*/

SELECT
customer_zip

FROM customer c 


WHERE customer_id IN (

		SELECT customer_id
		FROM customer_purchases

		WHERE product_id  = 7
		GROUP BY customer_id
		HAVING SUM(cost_to_customer_per_qty*quantity) >= 1000
	)