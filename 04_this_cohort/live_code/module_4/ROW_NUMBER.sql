--ROW_NUMBER 
--what product is the highest price per vendor

--outer QUERY

SELECT x.*,product_name

FROM (
--inner QUERY
	SELECT 
	vendor_id,
	market_date,
	product_id,
	original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank

	FROM vendor_inventory
) x
INNER JOIN product p 
	ON x.product_id = p.product_id

WHERE price_rank = 1;

--highest single purchase in a day PER customer 

SELECT * 
FROM (
	SELECT 
	customer_id
	,product_id
	,market_date
	,quantity
	,quantity*cost_to_customer_per_qty as cost
	,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY quantity*cost_to_customer_per_qty DESC) as sales_rank

	FROM customer_purchases
) x
WHERE sales_rank = 1
ORDER BY cost DESC