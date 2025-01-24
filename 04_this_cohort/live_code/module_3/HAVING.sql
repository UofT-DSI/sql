--HAVING

--how many products were bought
SELECT 
count(product_id) as number_products
,product_id

FROM customer_purchases
WHERE product_id <= 8
GROUP BY product_id
HAVING count(product_id) BETWEEN 300 AND 500
