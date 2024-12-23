-- COUNT

--count the number of products
SELECT count(product_id) AS num_of_prod
FROM product;

-- how many products per product_qty_type
SELECT product_qty_type, count(product_id)
FROM product
WHERE product_qty_type IS NOT NULL -- remove the NULL rows
GROUP BY product_qty_type;

--how many products per product_qty_type and per their product_size
SELECT product_size, product_qty_type, count(product_id)
FROM product
GROUP BY product_size, product_qty_type;

--how many UNIQUE products were bought
SELECT count(DISTINCT product_id)
FROM customer_purchases;
