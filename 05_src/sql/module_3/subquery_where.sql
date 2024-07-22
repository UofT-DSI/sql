--SUBQUERIES

-- where

-- what zip codes have had at least one customer spend 3000 at the farmers market

SELECT DISTINCT customer_zip

FROM customer

WHERE customer_id IN (
			SELECT customer_id--,SUM(quantity*cost_to_customer_per_qty)
			FROM customer_purchases

			GROUP BY customer_id
			HAVING SUM(quantity*cost_to_customer_per_qty) >= 3000
		);
		
		
-- whats the name of the vendor who sells pie

SELECT DISTINCT vendor_name

FROM vendor v
JOIN vendor_inventory as vi
	ON v.vendor_id = vi.vendor_id
	


WHERE product_id IN (

		SELECT product_id

		FROM product
		WHERE product_name LIKE '%pie%'
		
	)

