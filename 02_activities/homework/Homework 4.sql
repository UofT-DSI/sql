-- COALESCE 
SELECT 
    product_name || ', ' || 
    COALESCE(product_size, '') || ' (' || 
    COALESCE(product_qty_type, 'unit') || ')' AS product_details
FROM product;


-- visits per customer 
SELECT 
    customer_id,
    market_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM customer_purchases;

-- reverse numbering/most recent visit
WITH VisitNumbering AS (
    SELECT 
        customer_id,
        market_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
    FROM customer_purchases
)
SELECT * FROM VisitNumbering WHERE visit_number = 1;

-- count purchases/customer/product 
SELECT 
    customer_id,
    product_id,
    COUNT(*) OVER (PARTITION BY customer_id, product_id) AS purchase_count
FROM customer_purchases;

-- string manipulation
SELECT 
    TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1)) AS description
FROM product
WHERE INSTR(product_name, '-') > 0;

-- UNION - highest/lowest sales day
WITH SalesRanking AS (
    SELECT 
        market_date,
        SUM(quantity) AS total_sales,
        RANK() OVER (ORDER BY SUM(quantity) DESC) AS rank_desc,
        RANK() OVER (ORDER BY SUM(quantity)) AS rank_asc
    FROM customer_purchases
    GROUP BY market_date
)
SELECT market_date, total_sales FROM SalesRanking WHERE rank_desc = 1
UNION
SELECT market_date, total_sales FROM SalesRanking WHERE rank_asc = 1;
