/* MODULE 2 */
/* DISTINCT */


/* 1. Compare how many customer_ids are the customer_purchases table, one select with distinct, one without */

-- 4221 rows
SELECT customer_id FROM customer_purchases 

-- 26 rows
SELECT DISTINCT customer_id FROM customer_purchases 

/* 2. Compare the difference between selecting market_day in market_date_info, with and without distinct:
 what do these difference mean?*/

-- 150 rows
SELECT market_day
FROM market_date_info;

-- 2 rows
SELECT DISTINCT market_day
FROM market_date_info;
 
/* 3. Which vendor has sold products to a customer */
SELECT DISTINCT vendor_id
FROM customer_purchases;


/* 4. Which vendor has sold products to a customer ... and which product was it */

SELECT DISTINCT


/* 5. Which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/


/* 2. Compare the difference between selecting market_day in market_date_info, with and without distinct:
 what do these difference mean?*/
-- market is open for 150 days
 SELECT market_day
 FROM market_date_info;
 
 -- market is only open on 2 days, wed and sat
 SELECT DISTINCT market_day
 FROM market_date_info;
 
 

/* 3. Which vendor has sold products to a customer */
-- 3 vendors have sold products
SELECT DISTINCT vendor_id
FROM customer_purchases;


/* 4. Which vendor has sold products to a customer ... and which product was it */
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases;


/* 5. Which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/
SELECT DISTINCT vendor_id, product_id,customer_id
FROM customer_purchases



/* MODULE 2 */
/* INNER JOIN */


/* 1. Get product names (from product table) alongside customer_purchases 
 ... use an INNER JOIN to see only products that have been purchased */
 
-- without table aliases
SELECT product_name, -- from the product TABLE
vendor_id,
market_date,
customer_id,
customer_purchases.product_id,
product.product_id

FROM product
INNER JOIN customer_purchases
	ON customer_purchases.product_id=product.product_id




/* 2. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Add customers' first and last names with an INNER JOIN  */

-- using table aliases

/* MODULE 2 */
/* INNER JOIN */


/* 1. Get product names (from product table) alongside customer_purchases 
 ... use an INNER JOIN to see only products that have been purchased */
 
-- without table aliases
SELECT product_name, -- coming from the product TABLE
vendor_id, -- rest are coming from customer_purchases
market_date,
customer_id, 
customer_purchases.product_id,
product.product_id

FROM product
INNER JOIN customer_purchases
	ON customer_purchases.product_id = product.product_id;



/* 2. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Add customers' first and last names with an INNER JOIN  */

-- using table aliases
SELECT DISTINCT 
vendor_id, 
product_id, 
c.customer_id,
customer_first_name, -- coming from customer
customer_last_name  -- coming from customer


FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id
	


/* MODULE 2 */
/* LEFT  JOIN */


/* 1. There are products that have been bought
... but are there products that have not been bought? 
Use a LEFT JOIN to find out*/
SELECT DISTINCT 
p.product_id
,cp.product_id as [cp.product_id]
,product_name

FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id;



/* 2. Directions of LEFT JOINs matter ...*/
-- only products that have been sold ... because there are no product ids in CP that ARENT in product
SELECT DISTINCT 
p.product_id
,cp.product_id as [cp.product_id]
,product_name

FROM customer_purchases as p
LEFT JOIN product  as cp
	ON p.product_id = cp.product_id


/* 3. As do which table's values you filter on ... */
SELECT DISTINCT 
p.product_id
,cp.product_id as [cp.product_id]
,product_name

FROM product as p
LEFT JOIN customer_purchases as cp
	ON p.product_id = cp.product_id

WHERE p.product_id BETWEEN 1 AND 6 -- if we pick product, 6 rows (1-6), otherwise 5 rows because zinnias not been bought



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

FROM product AS p
LEFT JOIN product_category AS pc
	ON pc.product_category_id = p.product_category_id
	ORDER by pc.product_category_id

