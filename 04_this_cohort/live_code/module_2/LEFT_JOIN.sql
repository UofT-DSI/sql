/* MODULE 2 */
/* LEFT  JOIN */


/* 1. There are products that have been bought
... but are there products that have not been bought? 
Use a LEFT JOIN to find out*/
SELECT  DISTINCT
p.product_id 
,cp.product_id as [cp.product_id]
,product_name

FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id;


/* 2. Directions of LEFT JOINs matter ...*/
SELECT  DISTINCT
p.product_id 
,cp.product_id as [cp.product_id]
,product_name

FROM customer_purchases as cp
LEFT JOIN product as p
	ON p.product_id = cp.product_id;



/* 3. As do which values you filter on ... */
SELECT  DISTINCT
p.product_id 
,cp.product_id as [cp.product_id]
,product_name

FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id

WHERE p.product_id BETWEEN 1 AND 6  -- if we pick product, 6 rows (1-6) but if we pick cp....only 5 rows because zinnias never existed in customer purchases table



/* 4. Without using a RIGHT JOIN, make this query return the RIGHT JOIN result set
...**Hint, flip the order of the joins** ...

SELECT *

FROM product_category AS pc
LEFT JOIN product AS p
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id

...Note how the row count changed from 24 to 23
*/	

SELECT * 
FROM product as p
LEFT JOIN product_category as pc
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id


--------------------------------------------------------------------------------------------------------------------------------------------
