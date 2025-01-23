--SUBQUERIES: join

-- "what is the single item that has been bought in the greatest quantity

--outer query
SELECT 
product_name
,max(quantity)

FROM product p
INNER JOIN (

--inner query
	SELECT 
	product_id
	,count(quantity) as quantity

	FROM customer_purchases
	GROUP BY product_id
	
) x ON p.product_id = x.product_id