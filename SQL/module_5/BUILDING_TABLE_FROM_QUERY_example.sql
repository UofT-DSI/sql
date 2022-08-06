/* Making a table from this query */
SELECT *,pc.product_category_name

FROM product p
JOIN product_category pc ON p.product_category_id = pc.product_category_id;


CREATE TABLE "main" ("product_id", "product_name", "product_size", 
"product_category_id", "product_qty_type", "product_category_name") ;