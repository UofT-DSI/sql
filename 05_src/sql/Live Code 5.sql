--INNER JOIN

-- SELECT product.product_id, vendor_id, market_date,customer_id,product_name
-- 
-- FROM customer_purchases
-- INNER JOIN product
--  ON customer_purchases.product_id = product.product_id


SELECT DISTINCT p.product_id, product_name
FROM product as p
INNER JOIN customer_purchases as cp
 ON	p.product_id = cp.product_id

