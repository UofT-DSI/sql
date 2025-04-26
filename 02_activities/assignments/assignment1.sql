/* ASSIGNMENT 1 */
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */


SELECT * FROM customer;


/* 2. Write a query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */

SELECT * FROM customer;
SELECT *
FROM customer
ORDER BY customer_last_name ASC, customer_first_name ASC
LIMIT 10;


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1

/* query rows with the conditions*/

SELECT * ;
FROM product_id;
WHERE product_id = 4 OR product_id = 9;


/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1

/* query all customer purchases */

SELECT * FROM customer_purchases

/*create a new column called price*/
	
ALTER TABLE customer_purchases
ADD COLUMN quantity * cost_to_customer_per_qty AS price

/* filter by vendor IDs between 8 and 10 (inclusive) using 3 conditions AND */
	
WHERE vendor_id >= 8 AND vendor_id <= 10;

-- option 2


ALTER TABLE customer_purchases
ADD COLUMN quantity * cost_to_customer_per_qty AS price

/* using BETWEEN */
	
FROM price
WHERE vendor_id BETWEEN 8 AND 10;


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

/* select product table and columns product id and product name within that table */

SELECT 
product_id,
product_name,
FROM product 

/*add a new column called prod_qty_type_condensed*/
	
ALTER TABLE product

ADD COLUMN prod_qty_type_condensed

/* make the new column display unit if product_qty_type is unit, otherwise display bulk */

UPDATE product

SET prod_qty_type_condensed = bulk,

WHERE product_qty_type = 'unit' SET prod_qty_type_condensed = 'unit';


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
/* select product table and add a new column called pepper_flag */

ALTER TABLE product 

ADD COLUMN pepper_flag

/*set pepper_flag to the default value of 0 */

SET pepper_flag = 0

/* if product_name contains the word pepper or Pepper, set pepper_flag column to 1 */

WHERE product_name = pepper or Pepper
SET pepper_flag = '1';


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */

/* inner join vendor table to vendor_booth_assignments table on the vendor_id field */

SELECT * FROM vendor

SELECT * FROM vendor_booth_assignments

SELECT * FROM vendor INNER JOIN vendor_booth_assignments on vendor.vendor_id=vendor_booth_assignments.vendor_id

/* sort the result by vendor_name, then market_date */
	
SELECT vendor_id,
ORDER BY vendor_name, market_date;


/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */


SELECT vendor_booth_assignments,
COUNT (*)
FROM vendor_booth_assignments
GROUP BY vendor_id;


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

/* join customer table with customer_purchases table using the customer_id as the common field */

SELECT * FROM customer

SELECT * FROM customer_purchases

SELECT * FROM customer INNER JOIN customer_purchases on customer.customer_id=customer_purchases.customer_id

/* create a new column called total_spent */

ALTER TABLE customer_purchases

ADD COLUMN quantity * cost_to_customer_per_qty AS total_spent

/*Identity customers who spent more than $2000 at the market */
	
SELECT customer_id,
COUNT(*)
FROM total_spent
GROUP BY customer_id
HAVING COUNT (*) > 2000

/* Sort by customer last name, then first name */
	
ORDER BY customer_last_name, customer_first_name;


--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/



/* first drop the table if it exists before making the temp table */

DROP TABLE IF EXISTS temp.new_vendor;

/* Create new table*/

CREATE TABLE temp.new_vendor AS 
SELECT *, 
FROM vendor;

/* Insert 10th vendor */

INSERT INTO temp.new_vendor (vendor_number, vendor_first_name, vendor_last_name, type_of_store, name_of_store)
VALUES ('10', 'Thomas', 'Rosenthal', 'Fresh Focused Store', 'THOMAS Superfood Store');

/*end of assignment 1 syntax because I recall Thomas said during class to ignore the date questions. Please let me know if these are required and I will complete them below */



-- Date 




/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */



/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

