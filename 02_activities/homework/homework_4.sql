-- COALESCE
SELECT 
COALESCE(product_name, '') || ', ' || 
COALESCE(product_size, '') || ' (' || 
COALESCE(product_qty_type, 'unit') || ')' AS product_details
FROM product;


--Windowed Functions
SELECT customer_id, market_date, 
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM customer_purchases;


SELECT customer_id, market_date, 
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
FROM customer_purchases;


WITH numbered_visits AS (
    SELECT customer_id, market_date, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
    FROM customer_purchases
)
SELECT * 
FROM numbered_visits
WHERE visit_number = 1;

SELECT customer_id, product_id, market_date, 
COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count
FROM customer_purchases;


-- String manipulations
SELECT product_name,
TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1)) AS description
FROM product
WHERE INSTR(product_name, '-') > 0;



-- UNION
WITH sales_per_day AS (
    SELECT market_date, SUM(sales_amount) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
)

, ranked_sales AS (
    SELECT market_date, total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM sales_per_day
)

SELECT market_date, total_sales, 'Highest Sales Day' AS sales_type
FROM ranked_sales
WHERE sales_rank = 1
UNION
SELECT market_date, total_sales, 'Lowest Sales Day' AS sales_type
FROM ranked_sales
ORDER BY total_sales DESC;




