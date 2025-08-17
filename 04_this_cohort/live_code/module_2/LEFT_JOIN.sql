-- LEFT JOIN

-- there are products that have been bought, but are there products that have not been bought?

SELECT DISTINCT 
p.product_id
,cp.product_id as [cp.product_id]
,product_name

FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id

WHERE cp.product_id IS NULL; -- only show product ids that have not been sold

-- directions matter
-- this shows ONLY producst that have been sold...because there are no products id in cp that ARENT in product
SELECT DISTINCT 
p.product_id
,cp.product_id as [cp.product_id]
,product_name

FROM customer_purchases  as cp
LEFT JOIN product as p
	ON p.product_id = cp.product_id
