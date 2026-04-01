/* MODULE 4 */
/* NULL Management */


/* 1. IFNULL: Missing product_size, missing product_qty_type */ 
SELECT *
,IFNULL(product_size,'Unknown') as new_product_size
--replace with another COLUMN
,IFNULL(product_size,product_qty_type) as silly_replacement

/* 2. Coalesce */
,coalesce(product_size, product_qty_type, 'missing') as more_replacements -- if the first value is null, then replace with second value, unless that is null, then replace with "missing"
,coalesce(product_qty_type,product_size,'missing') as even_more_replacements

FROM product;

/* 3. NULLIF
finding values in the product_size column that are "blank" strings and setting them to NULL if they are blank */
SELECT *
--,IFNULL(product_size,'Unknown')
--,NULLIF(product_size,'')
,coalesce(NULLIF(product_size,''),'Unknown') as replaced_values

FROM product;


/* 4. NULLIF 
filtering which rows are null or blank */

SELECT * 
,NULLIF(product_size,'')
FROM product

WHERE NULLIF(product_size,'') IS NULL

--------------------------------------------------------------------------------------------------------------------------------------------
