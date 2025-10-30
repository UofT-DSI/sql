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
	ON c.customer_id = cp.customer_id;
	
SELECT DISTINCT product_name, -- coming from the product TABLE
customer_purchases.product_id,
product.product_id

FROM product
INNER JOIN customer_purchases
	ON customer_purchases.product_id = product.product_id;
	


