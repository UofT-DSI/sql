--IFNULL and coalesce & NULLIF

SELECT *
,IFNULL(product_size,'Unknown') 

--replace with another COLUMN
,IFNULL(product_size, product_qty_type)
,coalesce(product_size, product_qty_type)
,coalesce(product_size,product_qty_type,'missing') -- if the first value is null, then the second value, if that is null, then the third value (missing) 

,IFNULL(IFNULL(product_size, product_qty_type),'missing') -- same as above but with two ifnulls

FROM product;

SELECT *
,coalesce(product_size,'Unknown') -- we aren't successfully handling the blank value
--nullif
,NULLIF(product_size,'') -- find the values in product_size that "blanks" and set them to null
,coalesce(NULLIF(product_size,''),'Unknown')
,coalesce(NULLIF(TRIM(product_size),''),'Unknown') -- a trimmed blank so all white space becomes blank '     ' = ''

FROM product

WHERE NULLIF(product_size,'') IS NULL -- capturing BOTH nulls and blanks at the same time!