--arithmitic

SELECT DISTINCT
cost_to_customer_per_qty, CAST(cost_to_customer_per_qty AS INT) /2 
,FLOOR(10.5)
,POWER(2,4)
,pi()
,ROUND(10.5)
,POWER(cost_to_customer_per_qty, 2)

FROM customer_purchases