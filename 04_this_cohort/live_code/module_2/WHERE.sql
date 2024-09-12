--WHERE

-- SELECT * 
-- FROM customer
-- WHERE customer_id = 1
-- OR customer_id = 2;

-- SELECT * 
-- FROM customer_purchases
-- WHERE customer_id IN (3,4,5)
-- AND vendor_id IN (4,5);


--SELECT * FROM product
--WHERE product_name LIKE '%pepper%organic'

SELECT * FROM product
WHERE product_id IN (1,2)
OR product_size = 'medium'
