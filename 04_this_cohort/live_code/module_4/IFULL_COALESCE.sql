--IFNULL and coalesce + NULLIF

SELECT * 
,IFNULL(product_size, 'Unknown')

--less meaningful, but conceptual
--,IFNULL(product_size,product_category_id)
,IFNULL(product_size,product_qty_type)
,coalesce(product_size,product_qty_type, 'missing') -- this one is easier: if the first value is null, then the second value; if the second value is null, then the third value (and onwards if you have more arguments)
,IFNULL(IFNULL(product_size,product_qty_type),'missing')

FROM product;

SELECT *
,IFNULL(product_size, 'Unknown')

--nullif
,NULLIF(product_size, '') -- finding values in the product_size column that are "blanks" and setting them to NULL
,coalesce(NULLIF(product_size, ''),'unknown')

from product

WHERE NULLIF(product_size, '') IS NULL