-- COUNT

--count the number of products

SELECT COUNT(product_id) as num_of_prod
FROM product;

-- how many products PER product_qty_type
SELECT product_qty_type, COUNT(product_id) as num_of_prod
FROM product
GROUP BY product_qty_type;

--how many products PER product_qty_type and PER their product_size
SELECT product_size, product_qty_type, COUNT(product_id) as num_of_prod
FROM product
GROUP BY product_size, product_qty_type;

--count DISTINCT
--how many UNIQUE products were bought

SELECT count(DISTINCT  product_id) as bought_prods
FROM customer_purchases;



