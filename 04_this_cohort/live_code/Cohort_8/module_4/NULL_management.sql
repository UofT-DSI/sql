/* MODULE 4 */
/* NULL Management */


/* 1. IFNULL: Missing product_size, missing product_qty_type */ 

SELECT * 
,IFNULL(product_size, 'Unknown') as new_product_size
,IFNULL(product_size,product_qty_type) as both_null

/* 2. Coalesce */
,coalesce(product_size,product_qty_type) as still_both_null
,coalesce(product_size, product_qty_type, 'missing') as new_col -- if the first value is null, then the second value, if that is null, then missing

FROM product;


/* 3. NULLIF
finding values in the product_size column that are "blank" strings and setting them to NULL if they are blank */
SELECT *
,coalesce(product_size, 'Unknown') as new_product_size
,NULLIF(product_size,'') as nullif_check
,coalesce(NULLIF(product_size,''),'Unknown') as better_product_size

/* 4. NULLIF 
filtering which rows are null or blank */

FROM product

WHERE NULLIF(product_size,'') IS NULL
