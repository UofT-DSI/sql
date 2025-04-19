--LEFT JOIN

-- there are products that have been bought, but are there products that have not?

SELECT 
p.product_id, cp.product_id,
product_name -- all columns in cp table

FROM product p
LEFT JOIN customer_purchases cp
	ON p.product_id = cp.product_id;
	
SELECT DISTINCT
p.product_id, product_name, cp.product_id

FROM product p
LEFT JOIN customer_purchases cp
	ON p.product_id = cp.product_id
--WHERE cp.product_id IS NULL -- what products have been NOT been sold 

-- directions matter!
-- only products that have been sold...because there are no product ids in cp that arent in p
SELECT DISTINCT
p.product_id, product_name, cp.product_id

FROM customer_purchases cp
LEFT JOIN product p
	ON p.product_id = cp.product_id



	