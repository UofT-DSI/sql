--COALESCE
--Find the NULL values from the PRODUCT table  
SELECT *
 FROM product
 WHERE product_name IS NULL OR product_size IS NULL OR product_qty_type IS NULL

--Use COALESCE in the provided syntax to replace the NULL with a blank

SELECT 
product_name || ', ' || 
coalesce(product_size,' ')|| ' (' || 
coalesce(product_qty_type,' ')  || ')' 
FROM product

--Windowed Functions
--1.Write a query that selects from the customer_purchases table and numbers each customer’s visits 
--to the farmer’s market (labeling each market date with a different number). Each customer’s first 
--visit is labeled 1, second visit is labeled 2, etc.

--row_number()
SELECT 
customer_id,
market_date,
row_number()OVER(PARTITION BY customer_id ORDER BY market_date)as visit_number
FROM customer_purchases

--dense_rank()
SELECT 
customer_id,
market_date,
dense_rank()OVER(PARTITION BY customer_id ORDER BY market_date)as visit_number
FROM customer_purchases

--2.Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
--then write another query that uses this one as a subquery (or temp table) and filters the results to 
--only the customer’s most recent visit.

SELECT * FROM
(SELECT 
customer_id,
market_date,
row_number()OVER(PARTITION BY customer_id ORDER BY market_date DESC)as visit_number
FROM customer_purchases)x
WHERE x.visit_number = 1

--3.Using a COUNT() window function, include a value along with each row of the customer_purchases table
-- that indicates how many different times that customer has purchased that product_id.

SELECT
	customer_id,
	market_date,
	product_id,
	count(product_id) OVER(PARTITION BY customer_id)as purchase_count
	FROM customer_purchases


--String manipulations
-- Some product names in the product table have descriptions like "Jar" or "Organic". 
-- These are separated from the product name with a hyphen. Create a column using SUBSTR 
-- (and a couple of other commands) that captures these, but is otherwise NULL. Remove any 
-- trailing or leading whitespaces. Don't just use a case statement for each product!
-- product_name	description
-- Habanero Peppers - Organic	Organic
-- HINT: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help 
-- split the column.

SELECT product_name,
 CASE
  WHEN INSTR(product_name,'-')> 0
   THEN TRIM(SUBSTR(product_name, INSTR(product_name, '-')+1))
   ELSE NULL
 END AS description
FROM product;

-- UNION
-- Using a UNION, write a query that displays the market dates with the highest and 
-- lowest total sales.HINT: There are a possibly a few ways to do this query, but if 
-- you're struggling, try the following: 1) Create a CTE/Temp Table to find sales values
-- grouped dates; 2) Create another CTE/Temp table with a rank windowed function on the 
-- previous query to create "best day" and "worst day"; 3) Query the second temp table twice,
-- once for the best day, once for the worst day, with a UNION binding them.

-- 1. Created Temp table sales_by_date to find sales values for each market date with the columns, market date and the total sales
WITH sales_by_date AS (
    SELECT 
        market_date,
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM 
        customer_purchases
    GROUP BY 
        market_date
),
--2. Created another temp table sales_rank to rank the market dates on their total sales with the columns : market_date, total_sales, 
--sales_rank_highest, sales_rank_lowest
sales_rank AS (
     SELECT 
        market_date,
        total_sales,
        RANK()OVER(ORDER BY total_sales DESC) AS sales_rank_highest, 
        RANK()OVER(ORDER BY total_sales ASC) AS sales_rank_lowest
     FROM 
        sales_by_date)
		
--3. UNION two select queries from sales_rank table to retieve the highest total sales and 
--lowest total sales along with the market date

SELECT 
	market_date,
	total_sales 
FROM 
	sales_rank
WHERE 
	sales_rank_highest = 1
 
 UNION 
 
 SELECT 
	market_date,
	total_sales
 FROM 
	sales_rank 
 WHERE 
	sales_rank_lowest = 1
