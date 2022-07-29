SELECT customer_id
,COUNT(DISTINCT product_id) AS number_of_unique_items
,COUNT(product_id) AS number_of_purchases

FROM customer_purchases
GROUP BY  customer_id 