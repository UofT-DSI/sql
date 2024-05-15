--CASE

SELECT *
,CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
ELSE cost_to_customer_per_qty END as inflation

,CASE WHEN (cost_to_customer_per_qty <  AND customer_id = 14) THEN cost_to_customer_per_qty*10
	WHEN cost_to_customer_per_qty BETWEEN '1.01' AND '7.00' THEN cost_to_customer_per_qty*5
	ELSE cost_to_customer_per_qty END as super_inflation

,CASE WHEN cost_to_customer_per_qty < '1.00' THEN 1
--ELSE 0 END as inflation_sorter
END as inflation_sorter

FROM customer_purchases

ORDER BY CASE WHEN cost_to_customer_per_qty < '1.00' THEN 1 ELSE 0 END -- sorting