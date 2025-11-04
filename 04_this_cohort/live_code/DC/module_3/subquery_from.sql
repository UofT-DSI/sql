/* MODULE 3 */
/* Subquery FROM */


/*1. Simple subquery in a FROM statement, e.g. for inflation
...we could imagine joining this to a more complex query perhaps */
SELECT DISTINCT
product_id, inflation

FROM (
	SELECT product_id, cost_to_customer_per_qty,
	CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
	ELSE cost_to_customer_per_qty END AS inflation
	
	FROM customer_purchases
);


/* 2. What is the single item that has been bought in the greatest quantity?*/
--outer query
SELECT product_name, MAX(quantity_purchased)

FROM product AS p
INNER JOIN (
-- inner query
	SELECT product_id
	,count(quantity) as quantity_purchased

	FROM customer_purchases
	GROUP BY product_id
) AS x ON p.product_id = x.product_id

