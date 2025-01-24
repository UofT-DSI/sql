--arithmitic

SELECT 10.0/3.0 as division
,CAST (10.0 as INT) / CAST(3.0 as INT) as integer_division 
,sin(10)
,pi();

SELECT DISTINCT
cost_to_customer_per_qty
,cost_to_customer_per_qty / 2 as half
,CAST(cost_to_customer_per_qty as INT) / 2 -- equiv //2

FROM customer_purchases