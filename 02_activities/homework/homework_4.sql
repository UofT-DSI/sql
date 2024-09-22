-- SELECT 
-- COALESCE(product_name, '') || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')' as 'List'
-- FROM product;

-- corrected the columns by replacing their null value with the suggested values '' and 'unit'

-- SELECT 
-- vendor_id,
-- market_date,
-- customer_id,
-- DENSE_RANK() OVER ( PARTITION BY customer_id ORDER BY market_date) as Visit
-- 
-- FROM customer_purchases;
-- 
-- SELECT DISTINCT *
-- 
-- FROM(
-- 
-- 	SELECT 
-- 	customer_id,
-- 	DENSE_RANK() OVER ( PARTITION BY customer_id ORDER BY market_date DESC) as visit_num,
-- 	market_date
-- 
-- 	FROM customer_purchases
-- )v
-- WHERE v.visit_num = 1;
-- 
-- SELECT 
--     customer_id,
--     product_id,
--     COUNT(*) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count,
--     market_date,
--     quantity
-- FROM 
--     customer_purchases;
-- 	
-- SELECT 
--     product_name,
--     CASE 
--         WHEN INSTR(product_name, '-') > 0 THEN SUBSTR(product_name, INSTR(product_name, '-') + 2)
--         ELSE NULL 
--     END AS description
-- FROM 
--     product;
-- 	
-- 	
-- SELECT product_name,product_size
-- FROM product
-- WHERE product_size REGEXP '[0-9]';
	

WITH SalesByDate AS (
    SELECT 
        market_date,
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM 
        customer_purchases
    GROUP BY 
        market_date
),

RankedSales AS (
    SELECT 
        market_date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS best_day_rank,
        RANK() OVER (ORDER BY total_sales ASC) AS worst_day_rank
    FROM 
        SalesByDate
)

SELECT 
    market_date, 
    total_sales, 
    'Best Day' AS sales_type
FROM 
    RankedSales
WHERE 
    best_day_rank = 1

UNION

SELECT 
    market_date, 
    total_sales, 
    'Worst Day' AS sales_type
FROM 
    RankedSales
WHERE 
    worst_day_rank = 1;

