-- MORE COMPLEX QUERY  WE PUT IN R/PYTHON
-- THIS IS THE STARTING POINT FOR A SIMPLE REGRESSION EXAMPLE
-- SEE binomial_model.R or binomial_model.ipynb FILES 


WITH customer_markets_attended AS
(
	SELECT DISTINCT
	customer_id,
	market_date
	FROM customer_purchases
)

SELECT 
cp.market_date,
cp.customer_id,
SUM(cp.quantity * cp.cost_to_customer_per_qty) AS purchase_total,
COUNT(DISTINCT cp.vendor_id) AS vendor_patronized,
COUNT(DISTINCT cp.product_id) AS different_products_purchased,
CASE WHEN 
	CAST(
		JULIANDAY((SELECT MIN(cma.market_date)
										FROM customer_markets_attended AS cma
										WHERE cma.customer_id = cp.customer_id
										AND cma.market_date > cp.market_date
										GROUP BY cma.customer_id)) - 
		JULIANDAY(cp.market_date)
	AS INTEGER) <= 7 THEN 1 ELSE 0 END AS purchased_again_within_7_days

FROM customer_purchases AS cp
GROUP BY cp.market_date,
cp.customer_id