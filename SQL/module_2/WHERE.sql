-- WHERE

--SELECT * FROM customer
--WHERE customer_zip = 22801

-- SELECT * FROM customer_purchases
-- WHERE customer_id IN (14,22,23)
-- AND market_date = '2019-08-10'

/*
SELECT * FROM customer_purchases
WHERE  customer_id = 14
AND market_date = '2019-08-10'
OR market_date = '2019-07-03'
*/

--SELECT * FROM customer_purchases
--WHERE market_date BETWEEN '2019-01-01' AND '2019-12-31'

--SELECT * FROM customer
--WHERE customer_first_name LIKE '%a%'

--SELECT * FROM product
--WHERE product_size IS NULL

SELECT market_date
FROM customer_purchases

