--DISTINCT

-- what dates did at least one purchase occur for the farmersmarket
-- SELECT DISTINCT market_date
-- FROM customer_purchases

SELECT DISTINCT market_date,customer_id -- who has purchased at least one thing
FROM customer_purchases
ORDER BY customer_id
WHERE customer_id = 14