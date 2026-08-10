/* MODULE 4 */
/* NULL Management */


/* 1. IFNULL: Missing product_size, missing product_qty_type */ 
SELECT *
,IFNULL(product_size, 'Unknown') as new_product_size
,IFNULL(product_size,product_qty_type) as silly_replacement

/* 2. Coalesce */
,coalesce(product_size,product_qty_type,'missing') as more_replacement -- if the first value is null, then replace with the second value, if that is null, replace with the word "missing"
,coalesce(product_qty_type,product_size,'missing') as even_more_replacements
,IFNULL(IFNULL(product_qty_type,product_size),'missing') as same_as_above

FROM product;


/* 3. NULLIF
finding values in the product_size column that are "blank" strings and setting them to NULL if they are blank */
SELECT *
,IFNULL(product_size,'unknown') as not_both_nulls
,NULLIF(product_size,'') as both_nulls -- two single quotes
,coalesce(NULLIF(product_size,''),'unknown') as replaced_both

FROM product;


/* 4. NULLIF 
filtering which rows are null or blank */

SELECT *
,NULLIF(product_size,'') -- criteria we are filtering on

FROM product
WHERE NULLIF(product_size,'') IS NULL; -- how many blanks or nulls are there, in the same line


--------------------------------------------------------------------------------------------------------------------------------------------

SELECT * 
,CASE WHEN product_id < 5 THEN NULL ELSE product_id END

FROM product