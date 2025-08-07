--LEFT JOIN
--there are producst that have been bought, but are there products that have not been brought?


SELECT 
p.product_id,
cp.product_id AS [cp.product_id],
product_name

FROM product as p
LEFT JOIN customer_purchases AS CP
ON p.product_id = cp.product_id

WHERE cp.product_id IS NULL;


--direction matter
--this shows ONLY products that have been sold...
SELECT  DISTINCT
p.product_id,
cp.product_id AS [cp.product_id],
product_name

FROM customer_purchases AS CP
LEFT JOIN product as p
ON p.product_id = cp.product_id;







