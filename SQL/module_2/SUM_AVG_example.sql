SELECT product_category_name
,product_name
,SUM(cost_to_customer_per_qty*quantity) AS total_sales
--,AVG(cost_to_customer_per_qty*quantity)

FROM customer_purchases cp
JOIN product p 
	ON p.product_id = cp.product_id
JOIN product_category pc 
	ON p.product_category_id = pc.product_category_id

GROUP BY pc.product_category_name
,product_name

ORDER by total_sales DESC