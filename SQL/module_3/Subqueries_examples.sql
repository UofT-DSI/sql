--subqueries


SELECT DISTINCT p.product_id, MAX(max_quantity)

FROM product p
	
INNER JOIN (
		SELECT 
		cp.customer_id, product_id, MAX(quantity) AS max_quantity

		FROM customer_purchases as cp
		GROUP BY cp.customer_id, product_id
		--ORDER BY max_quantity DESC
		
	) x ON p.product_id = x.product_id




/*
SELECT * 

FROM vendor_inventory

WHERE product_id IN (

	SELECT product_id
	FROM product

	WHERE product_name LIKE '%eppe%'
)
*/

/*
SELECT DISTINCT

customer_zip
,median_household_income

FROM customer c
JOIN zip_data z on c.customer_zip = zip_code_5

WHERE customer_id IN (

	SELECT customer_id

	FROM customer_purchases
	WHERE product_id IN (8)
	GROUP BY customer_id
	HAVING SUM(cost_to_customer_per_qty*quantity) > 1000
	--ORDER BY total_spent DESC 
)
*/