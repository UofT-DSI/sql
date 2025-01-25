/* ASSIGNMENT 1 */
/* SECTION 2 */

-- By: Darshan Panesar

--SELECT
/* 1. Write a query that returns everything in the customer table. */

SELECT *
FROM customer

/* 2. Write a query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10

--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1

SELECT *
FROM customer_purchases
WHERE product_id = 4 OR product_id = 9; --OR included here instead of AND as AND would look for purchases where both 4 and 9

-- option 2


/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
SELECT *,
quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE  vendor_id <= 10 AND vendor_id >= 8;

-- option 2
SELECT *,
quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN  8 AND 10;


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

SELECT *,
	
CASE 
	WHEN product_qty_type = 'unit'
		THEN 'unit'
	ELSE  'bulk'
	
END AS 'product_qty_type_condensed'
	
FROM product;


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */

SELECT *,

CASE 
	WHEN product_name = 'pepper'
		THEN '1'
	ELSE '0'
	
END AS 'pepper_flag'

FROM product



--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */

SELECT *
FROM vendor
INNER JOIN vendor_booth_assignments AS vba
ON vendor.vendor_id = vba.vendor_id
ORDER BY vendor_name, market_date


/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT vendor_id,
COUNT (booth_number)
FROM vendor_booth_assignments
GROUP BY vendor_id;

--Should you wish to get specific numbers that each vendor rented specific booth numbers see below 
--SELECT vendor_id, booth_number,
--COUNT (booth_number)
--FROM vendor_booth_assignments
--GROUP BY booth_number, vendor_id;


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT *
--SUM(cost_to_customer_per_qty*quantity) AS money_spent --to have a sum column to see who spent how much add this line
FROM customer
INNER JOIN customer_purchases AS cp
	ON customer.customer_id = cp.customer_id
GROUP BY customer_last_name, customer_first_name
HAVING SUM(cost_to_customer_per_qty*quantity) > 2000;

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/


DROP TABLE IF EXISTS new_vendor;

CREATE TEMP TABLE new_vendor
AS
SELECT *
FROM vendor;
INSERT INTO new_vendor VALUES (10, 'Thomass Superfood Store', 'a Fresh Focused store', 'Thomas', 'Rosenthal');


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT customer_id, strftime('%m', market_date) AS month, strftime('%Y', market_date) AS year
FROM customer_purchases


/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT customer_id, strftime('%m', market_date) AS month, strftime('%Y', market_date) AS year,
SUM (cost_to_customer_per_qty*quantity)
AS money_spent
FROM customer_purchases
WHERE month = '04' AND year = '2022'
GROUP BY customer_id;





