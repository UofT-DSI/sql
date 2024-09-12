-- 1.
-- SELECT *
-- FROM customer_purchases
-- WHERE product_id IN (4, 9);

--2.
SELECT *, (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE vendor_id >= 8 AND vendor_id <=10;
