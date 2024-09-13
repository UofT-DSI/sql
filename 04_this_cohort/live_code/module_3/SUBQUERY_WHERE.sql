-- subquery: WHERE

-- what postal code have had at least one customer spend 3000 at the farmers market
SELECT DISTINCT customer_postal_code

FROM customer

WHERE customer_id IN 
(
	SELECT customer_id -- all time spending for each customer

	FROM customer_purchases
	group by customer_id
	HAVING sum(quantity*cost_to_customer_per_qty) > 3000
)

-- whats the name of the vendor who sell pie

SELECT DISTINCT vendor_name
FROM vendor as v
JOIN vendor_inventory as vi
	ON v.vendor_id = vi.vendor_id

WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)