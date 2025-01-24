--CASE

-- determine the prices
SELECT *,
quantity*cost_to_customer_per_qty as price,  -- quantity * cost per quantity
CASE WHEN cost_to_customer_per_qty < 1.00 -- if less then $1.00
	THEN cost_to_customer_per_qty * 2  -- double
	ELSE cost_to_customer_per_qty  -- otherwise, do nothing
	END as new_cost_per_qty,
	
CASE WHEN cost_to_customer_per_qty < 1.00
	THEN cost_to_customer_per_qty * 2 * quantity
	ELSE cost_to_customer_per_qty  * quantity
	END as new_price,
	
CASE WHEN cost_to_customer_per_qty < 1.00
	THEN cost_to_customer_per_qty * 5 * quantity -- make cheap things 5x more expensive
	WHEN cost_to_customer_per_qty BETWEEN 1.01 AND 5.00
	THEN cost_to_customer_per_qty * 2 * quantity -- make middle things 2x more expensive
	ELSE cost_to_customer_per_qty  * quantity
	END as new_new_price
	
FROM customer_purchases
ORDER by cost_to_customer_per_qty