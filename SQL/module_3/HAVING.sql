--HAVING

SELECT vendor_id,customer_id
,sum(quantity*cost_to_customer_per_qty) as total_spent

FROM customer_purchases
WHERE vendor_id = 4
GROUP BY vendor_id,customer_id
HAVING sum(quantity*cost_to_customer_per_qty) > 100
ORDER BY sum(quantity*cost_to_customer_per_qty) DESC