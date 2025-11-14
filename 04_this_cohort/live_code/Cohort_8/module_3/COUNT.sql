/* MODULE 3 */
/* COUNT */


/* 1. Count the number of products */
 SELECT COUNT(product_id) as num_of_prods
 FROM product;

 
/* 2. How many products per/by product_qty_type */
SELECT product_qty_type
,COUNT(product_id) as num_of_prods
FROM product
GROUP BY product_qty_type;


/* 3. How many products per product_qty_type and per their product_size */
SELECT product_size
,product_qty_type
,COUNT(product_id) as num_of_prods

FROM product
GROUP BY product_size, product_qty_type;


/* COUNT DISTINCT 
    4. How many unique products were bought */
    
 SELECT count(DISTINCT product_id) as bought_products
 FROM customer_purchases;


