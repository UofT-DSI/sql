/* MODULE 3 */
/* MIN & MAX */


/* 1. What is the most expensive product 
...pay attention to how it doesn't handle ties very well
*/
SELECT 
product_name
,max(original_price) as most_expensive

FROM product p
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id;
 

/* 2. Prove that max is working */
SELECT DISTINCT
product_name
,original_price

FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
ORDER BY original_price DESC;


/* 3. Find the minimum price per each product_qty_type */
SELECT 
product_name
,product_qty_type
,min(original_price) as least_expensive

FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id
GROUP BY product_qty_type

ORDER BY product_qty_type ASC, original_price ASC;


/* 4. Prove that min is working */
SELECT DISTINCT 
product_name
,product_qty_type
,original_price 

FROM product p 
INNER JOIN vendor_inventory vi
	ON p.product_id = vi.product_id

ORDER BY product_qty_type ASC, original_price ASC;


/* 5. Min/max on a string 
... not particularly useful? */
SELECT min(customer_first_name)
FROM customer


