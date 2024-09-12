-- 1.
-- SELECT product_id, product_name
-- ,CASE WHEN product_qty_type  =  'unit'
--                  THEN 'unit'
-- 				 ELSE 'bulk'
-- 				 END as product_qty_type_condensed
-- 				 
-- FROM product;

--2.
SELECT product_id, product_name
,CASE WHEN product_qty_type  =  'unit'
                 THEN 'unit'
				 ELSE 'bulk'
				 END as product_qty_type_condensed
,CASE WHEN lower(product_name) LIKE '%pepper%'
              THEN 1
              ELSE 0
			  END as pepper_flag
			  
FROM  product;
				 

