-- ISNULL, COALESCE

SELECT 
product_id
,product_name
,product_size
,product_category_id
,avg_value

,COALESCE(product_qty_type,avg_value)

 FROM product
 CROSS JOIN (
	select 
	avg(product_id) as avg_value
	
	FROM product
	)
		
