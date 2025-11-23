/* ASSIGNMENT 2 */
/* SECTION 2 */

-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product


But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first column with
nulls, and 'unit' for the second column with nulls. 

**HINT**: keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. 
Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. 
All the other rows will remain the same. */

SELECT 
	product_name 
	|| ', ' || 
	COALESCE(product_size,'') 
	|| ' (' || 
	COALESCE(product_qty_type,'unit') -- seems arbitrary?
--	COALESCE(product_qty_type, CASE WHEN RANDOM() < 0.5  THEN 'lbs' ELSE 'unit' END) -- let fate decide!
	|| ')' AS 'List of Products'
FROM product;
--WHERE (NULLIF(product_size,'') OR NULLIF(product_qty_type,'')) IS NULL; -- check 

/* improved formatting... *
SELECT 
	product_name 
	|| CASE WHEN NULLIF(product_size,'') IS NULL 
			THEN ' ' || COALESCE(product_size,'') ELSE ', ' || product_size END
	|| ' (' || COALESCE(product_qty_type,'unit') || ')' AS 'List of Products'
FROM product;
*/


--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */

/* ROW_NUMBER() approach: 
select only the unique market dates per customer (without purchase details)
and number those visits */
SELECT
customer_id,
market_date,
ROW_NUMBER() OVER(
	PARTITION BY customer_id 
	ORDER BY market_date ASC
	) AS visit_number

FROM (
	SELECT DISTINCT market_date, customer_id 
	FROM customer_purchases 
); 

	
/* DENSE_RANK() approach:
display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer */
SELECT *,
DENSE_RANK() OVER(
	PARTITION BY customer_id 
	ORDER BY market_date ASC
	) AS visit_number

FROM customer_purchases
ORDER BY customer_id, market_date;



/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */

SELECT *
--vendor_id, market_date,customer_id,transaction_time,
--x.recency_rank,
--LENGTH(transaction_time) AS len,
--HEX(transaction_time) AS hex_value,
--TIME(TRIM(transaction_time)) AS trimmed_time
FROM(
	SELECT *,
		ROW_NUMBER() OVER( -- DENSE_RANK() gives n+1 customer rows
			PARTITION BY customer_id 
			ORDER BY market_date DESC, 
--				TIME(TRIM(transaction_time)) DESC -- still wrong
				-- zero padding, trim blank space, convert to time
				TIME(TRIM(
					CASE WHEN SUBSTR(transaction_time,2,1)=':'
						THEN '0' || transaction_time ELSE transaction_time 
					END )) DESC
			) AS recency_rank
	FROM customer_purchases
) AS x
--WHERE recency_rank IN (1,2,3,4)  AND customer_id IN (1,2) AND market_date = '2023-10-13' -- check accuracy of ranking
WHERE recency_rank = 1 -- return only most recent visit
ORDER BY customer_id;


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */

/****************************************************************/
/* COUNT HOW MANY TIMES EACH CUSTOMER HAS BOUGHT EACH PRODUCT ****/
/* ASSUMPTIONS: count distinct transactions; append totals to customer_purchases*/
/****************************************************************/
-- METHOD 1a: WINDOWED FUNCTION; distinct transactions 
SELECT *, -- cp.*, p.product_name,
	COUNT(*) OVER(
		PARTITION BY customer_id, product_id  -- PARTITION BY cp.customer_id, cp.product_id
		) AS total_product_transactions
FROM customer_purchases AS cp;
--INNER JOIN product AS p
--	ON p.product_id = cp.product_id;

--METHOD 1b: WINDOWED + CTE ; de-duplicate first 
WITH distinct_counts AS (
	SELECT DISTINCT customer_id, product_id, market_date
	FROM customer_purchases
) -- de-duplicate
, counts AS (
	SELECT *,
		COUNT(*) OVER(
			PARTITION BY customer_id, product_id
			) AS total_products
	FROM distinct_counts
)
-- append result
SELECT 
	cp.*,
	c.total_products AS total_products
FROM customer_purchases AS cp
	INNER JOIN counts AS c
		ON c.customer_id = cp.customer_id 
		AND c.product_id = cp.product_id
ORDER BY cp.customer_id;


-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */
SELECT *,
	CASE WHEN INSTR(product_name,'-') > 0 -- if hyphen exists trim
			THEN TRIM(SUBSTR(product_name, INSTR(product_name, '-') +1))
			ELSE NULL 
	END AS description
FROM product

/* 2. Filter the query to show any product_size value that contain a number with REGEXP. */
WHERE product_size REGEXP '.*[0-9].*'; -- contains any numbers anywhere


-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */
WITH daily_sales AS (
	SELECT 
		market_date,
		ROUND(SUM(quantity*cost_to_customer_per_qty),2) AS daily_total
	FROM customer_purchases
	GROUP BY market_date
),
ranked_sales AS (
	SELECT *,
		RANK() OVER(ORDER BY daily_total DESC) AS rnk
	FROM daily_sales 
)
SELECT market_date, daily_total FROM ranked_sales 
WHERE rnk = 1 -- highest
UNION 
SELECT market_date, daily_total FROM ranked_sales 
WHERE rnk = (SELECT MAX(rnk) FROM ranked_sales); -- lowest

/*we don't really need UNION at all though...
WITH daily_sales AS (
	SELECT 
		market_date,
		ROUND(SUM(quantity*cost_to_customer_per_qty),2) AS daily_total
	FROM customer_purchases
	GROUP BY market_date
),
x AS (
	SELECT *, 
		MIN(daily_total) OVER() AS min_sales, 
		MAX(daily_total) OVER() AS max_sales 
	FROM daily_sales
)
SELECT market_date, daily_total FROM x
WHERE daily_total = min_sales OR daily_total = max_sales;  
*/



/* SECTION 3 */

-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */



/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/



-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */




