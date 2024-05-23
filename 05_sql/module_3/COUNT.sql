--COUNT

--counting rows in a table
--SELECT count(*) FROM booth

/*
SELECT customer_id
,COUNT(product_id) -- total number of products purchased by customer
,COUNT(DISTINCT product_id) -- unique number of products purchased by customer

FROM customer_purchases
GROUP BY customer_id
*/

/*
SELECT count(customer_id) -- number of purchases per that day
,market_date


FROM customer_purchases
WHERE market_date BETWEEN '2019-04-01' AND '2019-04-30'
GROUP BY market_date

*/

SELECT  product_id, count(distinct customer_id)
FROM customer_purchases

GROUP BY product_id