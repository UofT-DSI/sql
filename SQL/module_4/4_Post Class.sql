--Date
/* 1. Using the customer_purchases table and STRFTIME select and group by the weekday and hour of the day, 
and count the distinct number of customers during each hour of the Wednesday and Saturday markets. 
HINT: the first STRFTIME will _not_ be day */

-- SELECT 
-- STRFTIME('%w', market_date),
-- STRFTIME('%H', transaction_time),
-- COUNT(customer_id)
-- 
-- FROM customer_purchases
-- GROUP BY
-- STRFTIME('%w', market_date),
-- STRFTIME('%H', transaction_time)


/* 2. **CHALLENGING!** Using two case statment add the day of the week name (0 = "Sunday", 1 = "Monday" etc) 
and change the transaction hour to Morning or Afternoon (< 12 = Morning, else Evening) to the previous query. 
Fix the group by to correctly calculate which period sold the most (3 rows total). */

-- SELECT 
--   case  strftime('%w', market_date) 
--   when '0' then 'Sunday'
--   when '1' then 'Monday'
--   when '2' then 'Tuesday'
--   when '3' then 'Wednesday'
--   when '4' then 'Thursday'
--   when '5' then 'Friday'
--   else 'Saturday' end as weekday,
-- CASE WHEN CAST(STRFTIME('%H', transaction_time) AS INTEGER) < 12
--   THEN 'Morning'
--   ELSE 'Afternoon'END as morning_afternoon,
-- COUNT(customer_id)
-- 
-- FROM customer_purchases
-- GROUP BY
-- STRFTIME('%w', market_date),
-- CASE WHEN CAST(STRFTIME('%H', transaction_time) AS INTEGER) < 12
--   THEN 'Morning'
--   ELSE 'Afternoon'END



-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */

-- SELECT *,
-- CASE WHEN INSTR(product_name,'-') > 0
-- THEN LTRIM(RTRIM(SUBSTR(product_name,INSTR(product_name,'-')+1)))
-- ELSE NULL END as description
-- 
-- FROM product


/* 2. FIlter the query to show any product_size value that contain a number with REGEXP. */
-- SELECT *,
-- CASE WHEN INSTR(product_name,'-') > 0
-- THEN LTRIM(RTRIM(SUBSTR(product_name,INSTR(product_name,'-')+1)))
-- ELSE NULL END as description
-- 
-- 
-- FROM product
-- WHERE product_size REGEXP '[0-9]' 


--Cross Join
/*1. Suppose every customer on record bought each item the vendor has in their inventory (for a single day). 
How much money would each vendor make per product? 
Show this by vendor_name (concatenate first and last) and product name, rather than using the IDs. */

-- SELECT DISTINCT vendor_name
-- ,sum(original_price) AS total
-- 
-- FROM (
-- 	SELECT DISTINCT 
-- 	vendor_owner_first_name || ' ' || vendor_owner_last_name AS vendor_name
-- 	,product_name
-- 	,original_price
-- 	,customer_name
-- 
-- 	FROM vendor_inventory vi
-- 	INNER JOIN vendor v
-- 		ON v.vendor_id = vi.vendor_id
-- 	INNER JOIN product p
-- 		ON p.product_id = vi.product_id 
-- 		
-- 	CROSS JOIN
-- 		(SELECT DISTINCT customer_first_name || ' ' || customer_last_name AS customer_name 
-- 		FROM CUSTOMER)
-- 	) x
-- GROUP BY vendor_name 


/* 2. What if we want to include every day the market is open? Modify the query to show how much each vendor could make. */

-- SELECT DISTINCT vendor_name
-- ,sum(original_price) AS total
-- 
-- FROM (
-- 	SELECT DISTINCT 
-- 	vendor_owner_first_name || ' ' || vendor_owner_last_name AS vendor_name
-- 	,product_name
-- 	,original_price
-- 	,customer_name
-- 	,market_date
-- 
-- 
-- 	FROM vendor_inventory vi
-- 	INNER JOIN vendor v
-- 		ON v.vendor_id = vi.vendor_id
-- 	INNER JOIN product p
-- 		ON p.product_id = vi.product_id 
-- 		
-- 	CROSS JOIN
-- 		(SELECT DISTINCT customer_first_name || ' ' || customer_last_name AS customer_name 
-- 		FROM CUSTOMER)
-- 	) x
-- GROUP BY vendor_name 