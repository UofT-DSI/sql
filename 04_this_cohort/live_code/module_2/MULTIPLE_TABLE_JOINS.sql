/* MODULE 2 */
/* Multiple Table JOINs */


/* 1. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Replace all the IDs (customer, vendor, and product) with the names instead*/ 
SELECT DISTINCT 
--vendor_id
vendor_name
,p.product_id
,product_name
,c.customer_id
,customer_first_name
,customer_last_name
FROM customer_purchases as cp
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id;



/* 2. Select product_category_name, everything from the product table, and then LEFT JOIN the customer_purchases table
... how does this LEFT JOIN affect the number of rows? 

Why do we have more rows now?*/
SELECT product_category_name, p.*
, cp.product_id as productid_in_cust_purchases_table

FROM product_category as pc
INNER JOIN product as p -- will give us product_name, product_size, product_qty_type
	ON p.product_category_id = pc.product_category_id
LEFT JOIN customer_purchases as cp
	ON cp.product_id = p.product_id
	
	
ORDER by cp.product_id
	


--------------------------------------------------------------------------------------------------------------------------------------------