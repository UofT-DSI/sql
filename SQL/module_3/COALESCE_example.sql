
--SELECT COALESCE(NULL,"thomas")

SELECT 
product_name || ', ' || COALESCE(product_size,'')|| ' (' || COALESCE(product_qty_type,'unit') || ')',
product_name || ', ' || COALESCE(product_size,'')|| ' (' || COALESCE(product_qty_type,product_size,product_name) || ')'
FROM product