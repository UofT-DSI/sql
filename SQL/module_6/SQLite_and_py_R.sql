-- BASIC SQL QUERY WE PUT IN R/PYTHON
-- SEE SQLite_and_R.R OR SQLite_and_python.ipynb FILES

SELECT p.*,
pc.product_category_name 
,0 as [a poorly named columnm],
product_id / pc.product_category_id 

FROM product p 
JOIN product_category pc 
ON p.product_category_id = pc.product_category_id

WHERE product_size IN ('small', 'medium')