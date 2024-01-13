--COUNT

-- SELECT COUNT(*) AS rows
-- FROM customer_purchases

SELECT market_date, count(vendor_id) as sales_made, count(DISTINCT customer_id) as number_of_custs
FROM customer_purchases
GROUP BY market_date
ORDER BY market_date