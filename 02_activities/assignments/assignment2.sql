/* ASSIGNMENT 2 */ --- FESOBI OLUWAMUYIWA
/* SECTION 2 */

-- COALESCE - Handle NULL values
SELECT 
    product_name || ', ' || COALESCE(product_size, '') || ' (' || COALESCE(product_qty_type, 'unit') || ')'
FROM product;

--Window function
SELECT 
    customer_id,
    market_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date ASC) AS visit_number
FROM customer_purchases;

--Reversing the numbering
SELECT 
    customer_id,
    market_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
FROM customer_purchases;

---Filtering only the most recent visit for each customer:

WITH RankedVisits AS (
    SELECT 
        customer_id,
        market_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
    FROM customer_purchases
)
SELECT customer_id, market_date
FROM RankedVisits
WHERE visit_number = 1;


--Count window function
WITH RankedVisits AS (
    SELECT 
        customer_id,
        market_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
    FROM customer_purchases
)
SELECT customer_id, market_date
FROM RankedVisits
WHERE visit_number = 1;

-- Count Window Function - Number of times a customer has purchased a product
SELECT 
    customer_id,
    product_id,
    COUNT(*) OVER (PARTITION BY customer_id, product_id) AS purchase_count
FROM customer_purchases;

--String Manipulation
SELECT 
    product_name,
    TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1)) AS description
FROM product
WHERE INSTR(product_name, '-') > 0;

--UNION - Market dates with highest and lowest total sales

WITH SalesData AS (
    SELECT 
        market_date,
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),
RankedSales AS (
    SELECT 
        market_date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS highest_rank,
        RANK() OVER (ORDER BY total_sales ASC) AS lowest_rank
    FROM SalesData
)
SELECT market_date, total_sales, 'Highest Sales' AS category
FROM RankedSales WHERE highest_rank = 1
UNION
SELECT market_date, total_sales, 'Lowest Sales' AS category
FROM RankedSales WHERE lowest_rank = 1;

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */




/* SECTION 3 */

--CROSS JOIN - Vendor revenue per product
SELECT 
    v.vendor_name, 
    p.product_name, 
    5 * vi.original_price AS revenue_per_product
FROM vendor v
CROSS JOIN (
    SELECT DISTINCT product_id, original_price FROM vendor_inventory
) vi
JOIN product p ON vi.product_id = p.product_id;


---INSERT - Create a product_units table
--CREATE TABLE product_units AS
--SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
--FROM product
--WHERE product_qty_type = 'unit';


---Insert a new record into product_units:

INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES (999, 'Apple Pie', 'Medium', 3, 'unit', CURRENT_TIMESTAMP);

--DELETE - Remove older record
DELETE FROM product_units 
WHERE product_id = 999
AND snapshot_timestamp = (SELECT MIN(snapshot_timestamp) FROM product_units WHERE product_id = 999);


--UPDATE - Add current_quantity column and update it
ALTER TABLE product_units ADD COLUMN current_quantity INT;

UPDATE product_units
SET current_quantity = COALESCE(
    (SELECT quantity FROM vendor_inventory vi WHERE vi.product_id = product_units.product_id ORDER BY market_date DESC LIMIT 1),
    0
);



