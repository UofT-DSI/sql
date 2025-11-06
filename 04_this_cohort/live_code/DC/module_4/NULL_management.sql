/* MODULE 4 */
/* NULL Management */


/* 1. IFNULL: Missing product_size, missing product_qty_type */ 
SELECT *
,IFNULL(product_size,'Unknown') as new_product_size
--replace with another column
,IFNULL(product_size,product_qty_type) as silly_replacement

/* 2. Coalesce */
,coalesce(product_size,product_qty_type,'missing') as more_replacements -- if the first value is null, then the second value, ... if the second value is null, then "missing"
,coalesce(product_qty_type,product_size,'missing') as more_replacements -- if the first value is null, then the second value, ... if the second value is null, then "missing"

,IFNULL(IFNULL(product_size,product_qty_type),'missing') as equiv_replacements -- if the first value is null, then the second value, ... if the second value is null, then "missing"


FROM product;


/* 3. NULLIF
finding values in the product_size column that are "blank" strings and setting them to NULL if they are blank */
SELECT *
--,IFNULL(product_size, 'Unknown')
--,NULLIF(product_size,'') 
,coalesce(NULLIF(product_size,''),'Unknown') replaced_values

FROM product;


/* 4. NULLIF 
filtering which rows are null or blank */

SELECT *
FROM product

WHERE NULLIF(product_size,'') IS NULL

