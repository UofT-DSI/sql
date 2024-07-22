--DISTINCT

SELECT DISTINCT vendor_id,product_id,customer_id

FROM customer_purchases

ORDER BY vendor_id, product_id, customer_id;

SELECT DISTINCT vendor_id,product_id,customer_id;

FROM customer_purchases
WHERE market_date BETWEEN '2019-04-04' AND '2019-04-30' -- adding this in affects the row counts, now we are only talking about customers who have purchased between these dates

ORDER BY vendor_id, product_id, customer_id;


