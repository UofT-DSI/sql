/* MODULE 3 */
/* Subquery FROM */


/*1. Simple subquery in a FROM statement, e.g. for inflation
...we could imagine joining this to a more complex query perhaps */

SELECT DISTINCT product_id, inflation

FROM (

	SELECT product_id
	,cost_to_customer_per_qty
	,CASE 
		WHEN cost_to_customer_per_qty < '1.00' 
		THEN cost_to_customer_per_qty*5
		ELSE cost_to_customer_per_qty END as inflation
	
	FROM customer_purchases
);


/* 2. What is the single item that has been bought in the greatest quantity?*/
SELECT product_name
,max(quantity_purchased)

FROM product p
INNER JOIN (
	SELECT product_id
	,COUNT(quantity) as quantity_purchased
	
	FROM customer_purchases
	GROUP BY product_id

) x ON p.product_id = x.product_id

