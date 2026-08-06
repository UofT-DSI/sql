/* MODULE 3 */
/* SUM & AVG */


/* 1. How much did customers spend each day */
SELECT
market_date
,customer_id
,SUM(quantity*cost_per_quantity) as total_spend

FROM customer_purchases
GROUP BY market_date,customer_id;
 

/* 2. How much does each customer spend on average */
SELECT
customer_first_name
,customer_last_name
,ROUND(AVG(quantity*cost_per_quantity),2) as avg_spend

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id

GROUP BY c.customer_id; -- why customer_id and not customer_last_name/customer_first_name -- in case of duplicate names!!


--------------------------------------------------------------------------------------------------------------------------------------------
