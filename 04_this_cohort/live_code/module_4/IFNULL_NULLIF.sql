--IFNULL and coalesce + NULLIF

SELECT *,
IFNULL(product_size,'Unknown') as new_product_size,
IFNULL(product_size, product_qty_type), -- both null, results will be null
coalesce(product_size,product_qty_type,'missing'), -- if first value is null, then second value, if thats null then third value
IFNULL(IFNULL(product_size, product_qty_type),'missing') -- same as coalesce but you have to wrap within itself


FROM product;

SELECT *,
IFNULL(product_size,'Unknown') as new_product_size,
NULLIF(product_size,'') as blank_finder, -- finding the values that product_size is "blank" and returning NULL
coalesce(NULLIF(product_size,''), 'Unknown') as good_product_size

FROM product
--WHERE product_size is null 
WHERE NULLIF(product_size,'') IS NULL -- both blanks and nulls
