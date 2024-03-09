-- IFNULL and coalesce + NULLIF

SELECT *
--,IFNULL(product_size, 'Unknown')
--,IFNULL(product_qty_type, 'unit')

-- not very meaningful
--,IFNULL(product_size, product_category_id)
,IFNULL(product_size,product_qty_type)
,coalesce(product_size,product_qty_type,'missing')

--NULLIF
,NULLIF(product_size,'') -- finding values in the product_size column that are "blank" strings and setting them to NULL if they are blank
--,NULLIF(5,5)
--,NULLIF(5,7)

FROM product
WHERE NULLIF(product_size,'') IS NULL -- very useful for filtering which rows are null or blank