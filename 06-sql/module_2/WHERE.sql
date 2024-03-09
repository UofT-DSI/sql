--WHERE

/*
--SELECT product_name,product_size
--FROM product
--WHERE product_name LIKE '%pepper%'

*/

--SELECT * 
--FROM product
--WHERE product_id = 1
--WHERE product_id IN (1,2,6)

-- SELECT product_name
-- FROM product
-- WHERE product_category_id = 1

-- SELECT * 
-- FROM product
-- WHERE product_id BETWEEN 2 AND 7
-- OR product_qty_type = 'unit'

SELECT * 
FROM product
WHERE product_size IS NOT NULL
ORDER BY product_category_id DESC --ASC
--LIMIT 10