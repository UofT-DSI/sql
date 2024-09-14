--arithmitic

-- SELECT 10.0 / 3.0 as division -- float divided by float
-- ,CAST(10.0 as INT) / CAST(3.0 as INT) as INTEGER_division
-- ,


SELECT DISTINCT
cost_to_customer_per_qty
,CAST(cost_to_customer_per_qty as INT) / 2 -- equiv to //2


FROM customer_purchases