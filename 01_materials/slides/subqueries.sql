-- subqueries : JOIN

-- "what is the signle item that has been bought in the greatest quantity

SELECT product_name
,max(quantity_purchased) 

FROM product p
INNER JOIN (
	SELECT product_id
	,COUNT(quantity) as quantity_purchased
	--,case when type of the product is unit then sum else count 

	FROM customer_purchases
	GROUP BY product_id
) x ON p.product_id = x.product_id;

-- simple subquery in a FROM statement "inflation"
SELECT DISTINCT product_id, inflation
FROM (
	SELECT product_id, cost_to_customer_per_qty,
		CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
		ELSE cost_to_customer_per_qty END as inflation 
FROM customer_purchases )







--subqueries: WHERE

-- how much did each customer spend at each vendor for each day at the market WHEN IT RAINS

SELECT 
market_date
,customer_id
,vendor_id
,SUM(quantity*cost_to_customer_per_qty) as total_cost

FROM customer_purchases

--filter by rain_flag
-- "what dates was it raining"
WHERE market_date IN 
	(
	SELECT market_date
	FROM market_date_info
	WHERE market_rain_flag = 1
	)

GROUP BY market_date
,customer_id
,vendor_id;

-- what is the name of the vendor who sells pie
SELECT DISTINCT vendor_name

FROM vendor v
INNER JOIN vendor_inventory vi
	ON v.vendor_id = vi.vendor_id

WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)



















