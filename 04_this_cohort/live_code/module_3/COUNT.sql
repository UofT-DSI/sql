-- COUNT

--count the number of products in the product TABLE
-- SELECT count(product_id)
-- FROM product

SELECT product_qty_type, count(product_id)
FROM product
WHERE product_qty_type IS NOT NULL
GROUP BY product_qty_type;

SELECT product_size, count(product_id)
FROM product
GROUP BY product_size

