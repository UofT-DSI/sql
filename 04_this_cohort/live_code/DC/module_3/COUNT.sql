/* MODULE 3 */
/* COUNT */


/* 1. Count the number of products */
 SELECT COUNT(product_id) as num_of_product
 FROM product;

 
/* 2. How many products per product_qty_type */
SELECT product_qty_type, COUNT(product_id) as num_of_product
FROM product
GROUP BY product_qty_type;

/* 3. How many products per product_qty_type and per their product_size */
SELECT product_size
,product_qty_type
, COUNT(product_id) as num_of_product
FROM product
GROUP BY product_size, product_qty_type

ORDER BY product_qty_type;

/* COUNT DISTINCT 
    4. How many unique products were bought */
SELECT COUNT(DISTINCT product_id) as bought_prods
FROM customer_purchases

