
SELECT *

FROM customer_purchases

WHERE product_id =  2
AND customer_id = 12
AND (quantity BETWEEN 1.5 and 3.0
     OR quantity BETWEEN 3.5 and 50.0)

ORDER BY quantity ASC

LIMIT 100;