/* MODULE 2 */
/* Multiple Table JOINs */


/* 1. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Replace all the IDs (customer, vendor, and product) with the names instead*/ 
SELECT DISTINCT 
--v.vendor_id
vendor_name
--, product_id
,product_name
--,customer_id -- first/last name
,customer_first_name
,customer_last_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id;


/* 2. Select product_category_name, everything from the product table, 
and then LEFT JOIN the customer_purchases table
... how does this LEFT JOIN affect the number of rows? 

Why do we have more rows now?*/

SELECT product_category_name, p.*, cp.product_id as productid_in_purchases_table

FROM product_category as pc
INNER JOIN product as p
	ON p.product_category_id = pc.product_category_id
LEFT JOIN customer_purchases as cp
	ON cp.product_id = p.product_id

ORDER BY cp.product_id
	
	