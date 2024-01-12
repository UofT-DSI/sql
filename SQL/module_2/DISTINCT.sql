-- DISTINCT

-- SELECT DISTINCT market_date
-- FROM customer_purchases


SELECT DISTINCT market_date,customer_id
FROM customer_purchases
ORDER BY market_date ASC, customer_id ASC
