--arithmitic

--different division types
SELECT 10.0/3.0 as division -- float divided by another float
,CAST(10.0 as INT) / CAST(3.0 as INT) as integer_division
,pi()
,sin(10);

SELECT 
cost_to_customer_per_qty,
cost_to_customer_per_qty / 2,
CAST (cost_to_customer_per_qty as INT) / 2 -- equiv to //2

FROM customer_purchases

