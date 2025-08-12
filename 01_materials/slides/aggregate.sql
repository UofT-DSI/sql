
--How many products
SELECT count(product_id) as num_prods from product;

select product_qty_type, count(product_id) as num_prods
 from product
 group by product_qty_type;

--how manu producst per product_qty_type and per their priduct size
SELECT 
product_size,
product_qty_type,
count(product_id) as num_of_prods
from product group by product_size,product_qty_type;


-- count
-- count the number of products

SELECT COUNT(product_id) as num_of_prods
FROM product;

--how many products per product_qty_type
SELECT product_qty_type,
COUNT(product_id) as num_of_prods
FROM product
GROUP BY product_qty_type;

--how many products per product_qty_type and per their product_size
SELECT 
product_size,
product_qty_type,
COUNT(product_id) as num_of_prods

FROM product

GROUP BY product_size,product_qty_type;

--count DISTINCT
--how many unique products were bought

SELECT count(DISTINCT product_id) as bought_products
FROM customer_purchases



