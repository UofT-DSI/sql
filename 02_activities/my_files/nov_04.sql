/* MODULE 2 */
/* Multiple Table JOINs */


/* 1. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Replace all the IDs (customer, vendor, and product) with the names instead*/ 
SELECT DISTINCT vendor_id, product_id,customer_id
FROM customer_purchases


/* 2. Select product_category_name, everything from the product table, and then LEFT JOIN the customer_purchases table
... how does this LEFT JOIN affect the number of rows? 

Why do we have more rows now?*/

/* 1. Using the Query #4 from DISTINCT earlier 
    (Which vendor has sold products to a customer AND which product was it AND to whom was it sold)

    Replace all the IDs (customer, vendor, and product) with the names instead*/ 
SELECT DISTINCT 
--v.vendor_id
vendor_name
--, product_id
,product_name
--,customer_id -- first/last name
,customer_first_name
,customer_last_name

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id;


/* 2. Select product_category_name, everything from the product table, 
and then LEFT JOIN the customer_purchases table
... how does this LEFT JOIN affect the number of rows? 

Why do we have more rows now?*/

SELECT product_category_name, p.*, cp.product_id as productid_in_purchases_table

FROM product_category as pc
INNER JOIN product as p
	ON p.product_category_id = pc.product_category_id
LEFT JOIN customer_purchases as cp
	ON cp.product_id = p.product_id

ORDER BY cp.product_id



SELECT product_size
,product_qty_type
,COUNT(product_id) as num_of_product
FROM product
GROUP BY product_qty_type



/* MODULE 3 */
/* COUNT */


/* 1. Count the number of products */
 SELECT COUNT(product_id) as num_of_product
 FROM product;

 
/* 2. How many products per product_qty_type */
SELECT product_qty_type, COUNT(product_id) as num_of_product
FROM product
GROUP BY product_qty_type;

/* 3. How many products per product_qty_type and per their product_size */
SELECT product_size
,product_qty_type
, COUNT(product_id) as num_of_product
FROM product
GROUP BY product_size, product_qty_type

ORDER BY product_qty_type;

/* COUNT DISTINCT 
    4. How many unique products were bought */
SELECT COUNT(DISTINCT product_id) as bought_prods
FROM customer_purchases


/* MODULE 3 */
/* SUM & AVG */


/* 1. How much did customers spend each (per) day */
SELECT
market_date
,customer_id
,SUM(quantity*cost_to_customer_per_qty) as total_spend

FROM customer_purchases
GROUP BY market_date,customer_id;
 

/* 2. How much does each customer spend on average */
SELECT 
customer_first_name
,customer_last_name
,ROUND(AVG(quantity*cost_to_customer_per_qty),2) as avg_spend

FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id

GROUP BY c.customer_id

/* MODULE 3 */
/* MIN & MAX */


/* 1. What is the most expensive product 
...pay attention to how it doesn't handle ties very well
*/
SELECT product_name, max(original_price)  as most_expensive

FROM vendor_inventory as vi
INNER JOIN product as p 
	ON p.product_id = vi.product_id;
 

/* 2. Prove that max is working */
SELECT DISTINCT
product_name,
original_price

FROM vendor_inventory as vi
INNER JOIN product as p 
	ON p.product_id = vi.product_id;


/* 3. Find the minimum price per each product_qty_type */
SELECT product_name
,product_qty_type
,min(original_price)

FROM vendor_inventory as vi
INNER JOIN product as p
	ON p.product_id = vi.product_id

GROUP BY product_qty_type;

/* 4. Prove that min is working */
SELECT DISTINCT product_name
,product_qty_type
--,min(original_price)
,original_price

FROM vendor_inventory as vi
INNER JOIN product as p
	ON p.product_id = vi.product_id;

/* 5. Min/max on a string 
... not particularly useful? */
SELECT max(product_name)
FROM product


/* MODULE 3 */
/* Arithmitic */


/* 1. power, pi(), ceiling, division, integer division, etc */
SELECT power(4,2), pi();

SELECT 10.0 / 3.0 as division,
CAST(10.0 as INT) / CAST(3.0 as INT) as integer_division;

/* 2. Every even vendor_id with modulo */
SELECT * FROM vendor
WHERE vendor_id % 2 = 0;

/* 3. What about every third?  */
SELECT * FROM vendor
WHERE vendor_id % 3 = 0;

/* MODULE 3 */
/* HAVING */


/* 1. How much did a customer spend on each day?
Filter to customer_id between 1 and 5 and total_spend > 50 
... What order of execution occurs?*/
SELECT 
market_date
,customer_id
,SUM(quantity*cost_to_customer_per_qty) as total_spend

FROM customer_purchases
WHERE customer_id BETWEEN 1 AND 5

GROUP BY market_date, customer_id 
HAVING total_spend > 50;

/* 2. How many products were bought?
Filter to number of purchases between 300 and 500  */
SELECT count(product_id) as num_of_prod, product_id
FROM customer_purchases
GROUP BY product_id
HAVING count(product_id) BETWEEN 300 AND 500



/* MODULE 3 */
/* Subquery FROM */


/*1. Simple subquery in a FROM statement, e.g. for inflation
...we could imagine joining this to a more complex query perhaps */
SELECT DISTINCT
product_id, inflation

FROM (
	SELECT product_id, cost_to_customer_per_qty,
	CASE WHEN cost_to_customer_per_qty < '1.00' THEN cost_to_customer_per_qty*5
	ELSE cost_to_customer_per_qty END AS inflation
	
	FROM customer_purchases
);


/* 2. What is the single item that has been bought in the greatest quantity?*/
--outer query
SELECT product_name, MAX(quantity_purchased)

FROM product AS p
INNER JOIN (
-- inner query
	SELECT product_id
	,count(quantity) as quantity_purchased

	FROM customer_purchases
	GROUP BY product_id
) AS x ON p.product_id = x.product_id


/* MODULE 3 */
/* Subquery WHERE */


/* 1. How much did each customer spend at each vendor for each day at the market WHEN IT RAINS */

SELECT 
market_date,
customer_id,
vendor_id,
SUM(quantity*cost_to_customer_per_qty) as total_spend

FROM customer_purchases

-- filter by rain_flag
-- "what dates was it raining"
WHERE market_date IN (
	SELECT market_date
	FROM market_date_info
	WHERE market_rain_flag = 1
)

GROUP BY market_date, vendor_id, customer_id;



/* 2. What is the name of the vendor who sells pie */

SELECT DISTINCT vendor_name

FROM customer_purchases as cp
INNER JOIN vendor as v
	ON cp.vendor_id = v.vendor_id
	
WHERE product_id IN (
	SELECT product_id
	FROM product
	WHERE product_name LIKE '%pie%'
)



/* MODULE 3 */
/* Temp Tables */


/* 1. Put our inflation query into a temp table, e.g. as temp.new_vendor_inventory*/

/* some structural code */
/* ...heads up, sometimes this query can be finnicky -- it's good to try highlighting different sections to help it succeed...*/

-- if a table named new_vendor_inventory exists, delete it, other do NOTHING
DROP TABLE IF EXISTS temp.new_vendor_inventory;

--make the table
CREATE TABLE temp.new_vendor_inventory AS

-- definition of the table
SELECT *, 
original_price*5 as inflation
FROM vendor_inventory;


/* 2. put the previous table into another temp table, e.g. as temp.new_new_vendor_inventory  */
DROP TABLE IF EXISTS temp.new_new_vendor_inventory;
CREATE TABLE temp.new_new_vendor_inventory AS

SELECT * 
,inflation*2 as super_inflation
FROM temp.new_vendor_inventory


/* MODULE 3 */
/* Common Table Expression (CTE) */


/* 1. Calculate sales per vendor per day */
WITH vendor_daily_sales AS (
	SELECT 
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) as sales

	FROM customer_purchases cp
	INNER JOIN vendor v -- we want the vendor_name
		ON v.vendor_id = cp.vendor_id
	INNER JOIN market_date_info md -- all the date columns
		ON cp.market_date = md.market_date

	GROUP BY md.market_date, v.vendor_id

)


/* ... re-aggregate the daily sales for each WEEK instead now  */

SELECT 
market_year
,market_week
,vendor_name
,SUM(sales) as sales

FROM vendor_daily_sales
GROUP BY market_year,market_week, vendor_name





