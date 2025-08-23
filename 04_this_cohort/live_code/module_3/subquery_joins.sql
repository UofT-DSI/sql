-- subqueries : JOIN

-- "what is the signle item that has been bought in the greatest quantity

SELECT product_name
,max(quantity_purchased) 

FROM product p
INNER JOIN (
	SELECT product_id
	,COUNT(quantity) as quantity_purchased
	--,case when type of the product is unit then sum else count 

	FROM customer_purchases
	GROUP BY product_id
) x ON p.product_id = x.product_id;

-- simple subquery in a FROM statement "inflation"
SELECT DISTINCT product_id, inflation
FROM (
	SELECT product_id, cost_to_customer_per_qty,
		CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
		ELSE cost_to_customer_per_qty END as inflation 
FROM customer_purchases )

