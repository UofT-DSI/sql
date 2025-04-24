--IFNULL and coalesce + NULLIF

SELECT *
,IFNULL(product_size, 'Unknown')

--replacing with another COLUMN
,IFNULL(product_size,product_qty_type)
,coalesce(product_size, product_qty_type, 'missing') -- the first value is null, then the second value, then the third value if 2nd is null
,IFNULL(IFNULL(product_size, product_qty_type),'missing') -- same as above but with two ifnulls

FROM product;


SELECT *
,coalesce(product_size, 'Unknown') -- we aren't handling the blank
nullif
,NULLIF(product_size,'') -- finding values in product_size that are "blanks" and setting it equal to NULL
,coalesce(NULLIF(product_size,''), 'unknown')

FROM product

WHERE NULLIF(product_size, '') IS NULL -- captures BOTH nulls and blanks in one!