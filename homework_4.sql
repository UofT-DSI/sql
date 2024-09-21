--COALESCE
SELECT 
COALESCE(product_name, '') || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')'
FROM product;

--Windowed Functions
--1.
SELECT *
,row_number() over (PARTITION BY customer_id ORDER BY market_date ASC, CAST(transaction_time AS TIME)) AS visit_number
FROM 
			customer_purchases;
--2.			
SELECT *
 ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC, transaction_time DESC) AS reversed_visit_number
FROM 
    customer_purchases;
	
SELECT * 

FROM (				
SELECT *
 ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC, transaction_time DESC) AS reversed_visit_number
FROM 
    customer_purchases
) x

WHERE x.reversed_visit_number = 1;
--3.
SELECT *
,count(*) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count
FROM customer_purchases;

--String manipulations
--1.
SELECT 
    product_name,
    CASE 
        WHEN INSTR(product_name, '-') > 0 
		THEN TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1))
        ELSE NULL
    END AS description
FROM 
    product;
			
--UNION
--1.
WITH sales_per_day AS (
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
        RANK() OVER (ORDER BY total_sales DESC) AS rank_highest,
        RANK() OVER (ORDER BY total_sales ASC) AS rank_lowest
    FROM 
        sales_per_day
)
-- Query to get both the highest and lowest sales days
SELECT 
    market_date, 
    total_sales, 
    'Highest Sales Day' AS sales_type
FROM 
    ranked_sales
WHERE 
    rank_highest = 1
UNION 
SELECT 
    market_date, 
    total_sales, 
    'Lowest Sales Day' AS sales_type
FROM 
    ranked_sales
WHERE 
    rank_lowest = 1;

