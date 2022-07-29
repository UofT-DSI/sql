SELECT customer_id, market_date
,COUNT(product_id) AS number_of_purchases

FROM customer_purchases
GROUP BY  market_date, customer_id

