/* MODULE 2 */
/* INNER JOIN */


/* 1. Get product names (from product table) alongside customer_purchases 
 ... use an INNER JOIN to see only products that have been purchased */
 
-- without table aliases
SELECT 
product_name, -- coming from product TABLE
vendor_id, -- coming from the customer_purchase table (and all below)
market_date,
customer_id,
customer_purchases.product_id

FROM product
INNER JOIN customer_purchases
	ON product.product_id = customer_purchases.product_id;



/* 2. Using the Query #5 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Add customers' first and last names with an INNER JOIN  */

-- using table aliases
SELECT DISTINCT 
vendor_id,
 product_id, 
 c.customer_id, -- from the customer table!
 customer_first_name,
 customer_last_name

 FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id 

