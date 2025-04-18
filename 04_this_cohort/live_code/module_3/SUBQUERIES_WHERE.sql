--SUBQUERIES: WHERE

-- how much did each customer spend at each vendor for each day at the market when it rains
SELECT 
market_date,
customer_id,
vendor_id,
SUM(quantity*cost_to_customer_per_qty) as total_cost

FROM customer_purchases

-- filter by rain_flag
-- "what dates was it raining"

WHERE market_date IN 
	(
	SELECT market_date FROM market_date_info
	WHERE market_rain_flag = 1
	)
GROUP BY market_date, vendor_id, customer_id;

-- what is the name of the vendor who sells pie?

SELECT DISTINCT vendor_name
FROM vendor_inventory vi
INNER JOIN vendor v
	ON vi.vendor_id = v.vendor_id

WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)

-- what is the name of the vendor who has SOLD pie(s)?

SELECT DISTINCT vendor_name
FROM customer_purchases cp -- minor contextual difference!
INNER JOIN vendor v
	ON cp.vendor_id = v.vendor_id

WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)
	





