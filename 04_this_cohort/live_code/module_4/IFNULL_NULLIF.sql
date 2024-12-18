--IFNULL and coalesce + NULLIF

SELECT *
,IFNULL(product_size, 'Unknown')  as new_product_size

--less meaningful "conceptual"
,IFNULL(product_size, product_qty_type) -- both null, results with null
,coalesce(product_size,product_qty_type,'missing') -- if first the value is null, the second is null, then do the third value
,IFNULL(IFNULL(product_size, product_qty_type),'missing') -- same but have to wrap within


FROM product;

SELECT *
,IFNULL(product_size, 'Unknown')  as new_product_size
,NULLIF(product_size, '') -- finding the values that product_size column is "blank" and setting them to null
,coalesce(NULLIF(product_size, ''),  'unknown') as good_product_size
,IFNULL(NULLIF(product_size, ''),  'unknown') as good_product_size

FROM product

WHERE NULLIF(product_size, '') IS NULL -- both blanks and NULLs
--WHERE product_size IS NULL -- only NULLs