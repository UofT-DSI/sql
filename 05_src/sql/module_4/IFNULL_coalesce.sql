--IFNULL and coalesce + NULLIF

SELECT *,
IFNULL(product_size,'Unknown')

--less meaningful
,IFNULL(product_size,product_category_id) as product_size
,IFNULL(product_size,product_qty_type) -- NULL NULL
,coalesce(product_size,product_qty_type,'missing')

FROM product;


SELECT *,
IFNULL(product_size,'Unknown') as product_size

--nullif
,NULLIF(product_size,'') -- findinv values in the product_size column that "blank" strings and setting them to null if they are blank


from product

WHERE 1=1
--AND product_size is null -- filter only null values (no blanks
AND NULLIF(product_size,'') IS NULL -- filtering rows BOTH null and blank