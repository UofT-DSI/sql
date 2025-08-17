-- INNER JOIN
-- INNER JOIN without an alias

--get product names alongside customer_purchases ... only products that a customer has purchased
SELECT 
product_name, -- come from product table
vendor_id, -- coming from the customer_purchases table ... below
market_date,
customer_id,
customer_purchases.product_id


FROM product
INNER JOIN customer_purchases
	ON customer_purchases.product_id = product.product_id;
	
-- which vendor has sold products to a customer AND which product was it AND to whom was it sold
SELECT DISTINCT vendor_id, 
c.customer_id,
customer_first_name, 
customer_last_name,  -- go and get this name
product_id
FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id




