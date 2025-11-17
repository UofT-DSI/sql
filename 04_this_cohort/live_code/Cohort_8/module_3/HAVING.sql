/* MODULE 3 */
/* HAVING */


/* 1. How much did a customer spend on each day?
Filter to customer_id between 1 and 5 and total_cost > 50 
... What order of execution occurs?*/

SELECT  -- fifth
market_date
,customer_id
,SUM(quantity*cost_to_customer_per_qty) as total_spend 

FROM customer_purchases -- first
WHERE customer_id BETWEEN 1 AND 5 --filtering the non-aggregated values, second

GROUP BY market_date, customer_id -- third
HAVING total_spend > 50; -- filtering the aggreated values (total spend), fourth
 


/* 2. How many products were bought?
Filter to number of purchases between 300 and 500  */
SELECT 
count(product_id) as number_of_products
,product_id

FROM customer_purchases

GROUP BY product_id
HAVING count(product_id) BETWEEN 300 AND 500 


