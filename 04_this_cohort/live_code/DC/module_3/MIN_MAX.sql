/* MODULE 3 */
/* MIN & MAX */


/* 1. What is the most expensive product 
...pay attention to how it doesn't handle ties very well
*/
SELECT product_name, max(original_price)  as most_expensive

FROM vendor_inventory as vi
INNER JOIN product as p 
	ON p.product_id = vi.product_id;
 

/* 2. Prove that max is working */
SELECT DISTINCT
product_name,
original_price

FROM vendor_inventory as vi
INNER JOIN product as p 
	ON p.product_id = vi.product_id;


/* 3. Find the minimum price per each product_qty_type */
SELECT product_name
,product_qty_type
,min(original_price)

FROM vendor_inventory as vi
INNER JOIN product as p
	ON p.product_id = vi.product_id

GROUP BY product_qty_type;

/* 4. Prove that min is working */
SELECT DISTINCT product_name
,product_qty_type
--,min(original_price)
,original_price

FROM vendor_inventory as vi
INNER JOIN product as p
	ON p.product_id = vi.product_id;

/* 5. Min/max on a string 
... not particularly useful? */
SELECT max(product_name)
FROM product

