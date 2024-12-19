--subqueries: WHERE

-- "what postal codes have had at least 3000? at the farmers market?"

SELECT DISTINCT customer_postal_code

FROM customer
WHERE customer_id IN (

	SELECT customer_id
	FROM customer_purchases
	GROUP BY customer_id 
	HAVING sum(quantity*cost_to_customer_per_qty)  > 3000
);

--'what is the name of the vendor who sells pie'
 
 SELECT DISTINCT vendor_name
 FROM vendor_inventory vi
 INNER JOIN vendor v 
	ON vi.vendor_id = v.vendor_id
 
 WHERE product_id IN (
 
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
	)