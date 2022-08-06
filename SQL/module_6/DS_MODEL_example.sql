--example datascience type query for R/python
WITH
    customer_markets_attended AS
    (
      SELECT DISTINCT
      customer_id,
      market_date
      FROM customer_purchases
      ORDER BY customer_id, market_date
    )
    SELECT
    cp.market_date,
    cp.customer_id,
    SUM(cp.quantity * cp.cost_to_customer_per_qty) AS purchase_total,
    COUNT(DISTINCT cp.vendor_id) AS vendors_patronized,
    COUNT(DISTINCT cp.product_id) AS different_products_purchased,
    CASE WHEN
    CAST(
      JULIANDAY((SELECT MIN(cma3.market_date)
                 FROM customer_markets_attended AS cma3
                 WHERE cma3.customer_id = cp.customer_id
                 AND cma3.market_date > cp.market_date
                 GROUP BY cma3.customer_id)) - 
        JULIANDAY(cp.market_date) AS INTEGER) <= 7
    THEN 1
    ELSE 0 END AS purchased_again_within_7_days
    FROM customer_purchases AS cp
    GROUP BY cp.customer_id, cp.market_date
    ORDER BY cp.customer_id, cp.market_date