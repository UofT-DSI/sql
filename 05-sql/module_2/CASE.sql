-- CASE

SELECT *
,CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5 
ELSE cost_to_customer_per_qty END AS inflation
,CASE WHEN cost_to_customer_per_qty < '1.00' THEN 1 
ELSE 0 END AS inflation_sort
,CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*10
			  WHEN cost_to_customer_per_qty BETWEEN '1.01' AND '7.00' THEN cost_to_customer_per_qty*5
			  ELSE cost_to_customer_per_qty END AS super_inflation

FROM customer_purchases
ORDER BY CASE WHEN cost_to_customer_per_qty < '1.00' THEN 1 ELSE 0 END DESC, -- "sorting by inflation sort desc"
	CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5  ELSE cost_to_customer_per_qty END ASC -- sorting by inflation (value) asc