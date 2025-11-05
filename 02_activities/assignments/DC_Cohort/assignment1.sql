/* ASSIGNMENT 1 */
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */
SELECT *
FROM customer;


/* 2. Write a query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
SELECT *
FROM customer_purchases
WHERE product_id IN (4, 9);


/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by customer IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
SELECT *
,quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE customer_id >= 8 AND customer_id <= 10;

-- option 2
SELECT *
,quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10;


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

SELECT product_id, product_name,
CASE WHEN LOWER(product_qty_type) = 'unit' THEN 'unit'
ELSE 'bulk' END AS prod_qty_type_condensed
FROM product;


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */

SELECT product_id, product_name,
CASE WHEN LOWER(product_qty_type) = 'unit' THEN 'unit'
ELSE 'bulk' END AS prod_qty_type_condensed,
CASE WHEN LOWER(product_name) LIKE '%pepper%' THEN 1
ELSE 0 END AS pepper_flag
FROM product;

--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */

SELECT v.vendor_id, v.vendor_name, vba.market_date, vba.booth_number
FROM vendor AS v
INNER JOIN vendor_booth_assignments AS vba
  ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date;



/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

-- 1. Count how many times each vendor has rented a booth
SELECT v.vendor_id, v.vendor_name,
COUNT(vba.booth_number) AS total_rentals
FROM vendor AS v
INNER JOIN vendor_booth_assignments AS vba
	ON v.vendor_id = vba.vendor_id
	GROUP BY v.vendor_id, v.vendor_name
	ORDER BY total_rentals DESC;



/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

-- 2. Customers who have spent more than $2000
SELECT c.customer_id, c.customer_first_name, c.customer_last_name,
SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
FROM customer AS c
INNER JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id
	GROUP BY c.customer_id, c.customer_first_name, c.customer_last_name
	HAVING total_spent > 2000
	ORDER BY c.customer_last_name, c.customer_first_name;

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

-- 3. Create a temp table and add a new vendor
CREATE TEMP TABLE new_vendor AS
SELECT *
FROM vendor;

INSERT INTO new_vendor (
  vendor_id,
  vendor_name,
  vendor_type,
  vendor_owner_first_name,
  vendor_owner_last_name
)
VALUES (
  10,
  'Thomass Superfood Store',
  'Fresh Focused',
  'Thomas',
  'Rosenthal'
);


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */



/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */




/* SECTION 4 

The article delves into how Pakistan’s national ID system (NADRA) embeds social expectations into technical database design. What seems like a neutral data system actually enforces a narrow definition of family—two married parents and biological ties. Riz’s story, where his ID renewal failed because the computer didn’t recognize his parents’ marriage, shows how a database can police and dictate who counts as legitimate in society.

By making every citizen’s record depend on approved family relationships, NADRA transforms cultural and political norms into digital rules. People who do not fit these norms—single mothers, orphans, refugees, or members of the khawaja sira (third-gender) community—are excluded by artificially designed discriminatory code. This turns social inequality into technical enforcement, revealing that fairness in technology is never automatic rather a reflection of those who build them.

The design of relational databases mirrors power structures: every record must connect neatly to another. But human lives don’t always follow those relationships. NADRA’s schema leaves no space for alternative family forms, forcing people to fake documents or attach themselves to unrelated families to access basic services. These constraints create structural marginalization, where technology amplifies social exclusion instead of reducing it.

As NADRA became central to voting, travel, banking, and healthcare, the consequences of these design choices deepened. When a card is blocked, the person effectively disappears from civic life. The system’s pursuit of accuracy ends up limiting freedom and equality. The article reminds me that databases, far from being neutral, reflect the assumptions of those who build them.

Data design is social design. Each primary key, constraint, or validation rule represents a judgment about what kinds of relationships are real or valid. Fair systems must be flexible enough to include everyone. True technological progress means not just efficient data—but inclusive models that recognize the diversity of human experience.


*/