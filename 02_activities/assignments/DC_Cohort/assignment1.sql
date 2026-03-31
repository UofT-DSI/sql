 /* ASSIGNMENT 1 */
--Please write responses between the QUERY # and END QUERY blocks
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */
--QUERY 1
SELECT * FROM customer;

--END QUERY


/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */
--QUERY 2
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

--END QUERY


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. 
Limit to 25 rows of output. */

SELECT *
FROM customer_purchases
WHERE product_id IN (4, 9)
LIMIT 25;



/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by customer IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
Limit to 25 rows of output.
*/
--QUERY 3
SELECT *, quantity*cost_to_customer_per_qty as price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10
LIMIT 25;

--END QUERY


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */
--QUERY 4
SELECT product_id, product_name
,CASE WHEN product_qty_type = 'unit' THEN 'unit'
ELSE 'bulk' 
END AS prod_qty_type_condensed
FROM product;

--END QUERY


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
--QUERY 5
SELECT product_id, product_name
,CASE WHEN product_qty_type = 'unit' THEN 'unit'
ELSE 'bulk' 
END AS prod_qty_type_condensed
,CASE WHEN product_name LIKE '%pepper%' THEN 1
ELSE 0
END AS pepper_flag
FROM product;

--END QUERY


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by market_date, then vendor_name.
Limit to 24 rows of output. */
--QUERY 6
SELECT *
FROM vendor AS v
INNER JOIN vendor_booth_assignments AS vba
		ON v.vendor_id = vba.vendor_id
ORDER BY market_date, vendor_name
LIMIT 24; 

--END QUERY



/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
--QUERY 7
SELECT vendor_id
, COUNT(market_date) AS times_rented
FROM vendor_booth_assignments
GROUP BY vendor_id;



--END QUERY


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
--QUERY 8
SELECT customer_last_name
, customer_first_name
, SUM (quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases as cp 
LEFT JOIN customer as c
		ON cp.customer_id = c.customer_id
GROUP BY cp.customer_id
HAVING total_spent > 2000
ORDER BY customer_last_name, customer_first_name;



--END QUERY


--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/
--QUERY 9
--making a copy of vendor table
DROP TABLE IF EXISTS temp.new_vendor;
CREATE TABLE temp.new_vendor AS 
SELECT * 
FROM vendor;

--adding 10th vendor 
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name) 
		VALUES(10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

--display the updated new_vendor table
SELECT * 
FROM temp.new_vendor;



--END QUERY


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! 
Limit to 25 rows of output. */
--QUERY 10




--END QUERY


/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement...
AND be sure you remove the LIMIT from the previous query before aggregating!! */
--QUERY 11




--END QUERY
