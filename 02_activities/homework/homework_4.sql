---COALESCE
SELECT 
    product_name || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')'
FROM 
    product;

---- Query for numbering customer visits:
SELECT 
    customer_id, 
    market_date, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM 
    customer_purchases;
	
--- Query for reverse numbering:
SELECT 
    customer_id, 
    market_date, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
FROM 
    customer_purchases;

--- Query to get only the most recent visit:
SELECT 
    customer_id, 
    market_date
FROM 
    (
        SELECT 
            customer_id, 
            market_date, 
            ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
        FROM 
            customer_purchases
    ) AS recent_visits
WHERE 
    visit_number = 1;

---- Query with COUNT() window function:
SELECT 
    customer_id, 
    product_id, 
    transaction_time, 
    COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS purchase_count
FROM 
    customer_purchases;

---- String Manipulation 
SELECT 
    product_name,
    TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1)) AS description
FROM 
    product
WHERE 
    INSTR(product_name, '-') > 0;
	
----	Query market dates with the highest and lowest total sales 
WITH daily_sales AS (
  SELECT transaction_time,
         SUM(quantity * cost_to_customer_per_qty) AS total_sales
  FROM customer_purchases
  GROUP BY transaction_time
),
ranked_sales AS (
  SELECT transaction_time,
         total_sales,
         RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
         RANK() OVER (ORDER BY total_sales ASC) AS reverse_rank
  FROM daily_sales
)
SELECT transaction_time, total_sales, 'Highest Sales' AS sales_type
FROM ranked_sales
WHERE sales_rank = 1
UNION
SELECT transaction_time, total_sales, 'Lowest Sales' AS sales_type
FROM ranked_sales
WHERE reverse_rank = 1
ORDER BY total_sales DESC;

-----------
WITH total_sales AS (
    SELECT 
        market_date, 
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM 
        customer_purchases
    GROUP BY 
        market_date
),
ranked_sales AS (
    SELECT 
        market_date, 
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS best_rank,
        RANK() OVER (ORDER BY total_sales ASC) AS worst_rank
    FROM 
        total_sales
)
SELECT 
    market_date, 
    total_sales, 
    'Best Day' AS sales_type
FROM 
    ranked_sales
WHERE 
    best_rank = 1

UNION

SELECT 
    market_date, 
    total_sales, 
    'Worst Day' AS sales_type
FROM 
    ranked_sales
WHERE 
    worst_rank = 1;

	

