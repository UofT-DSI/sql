 /* ASSIGNMENT 1 */
--Please write responses between the QUERY # and END QUERY blocks
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */
--QUERY 1
SELECT * FROM customer

--END QUERY


/* 2. Write a query that displays all of the columns and 10 rows from the customer table, 
sorted by customer_last_name, then customer_first_ name. */
--QUERY 2
SELECT customer_id, customer_first_name, customer_last_name, customer_postal_code
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10

--END QUERY


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. 
Limit to 25 rows of output. */
--QUERY 3
SELECT *
FROM customer_purchases
WHERE product_id IN (4,9)
LIMIT 25

--END QUERY



/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by customer IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
Limit to 25 rows of output.
*/
--QUERY 4
SELECT *
,quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10
LIMIT 25

--END QUERY


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */
--QUERY 5
SELECT product_id, product_name,
	CASE WHEN product_qty_type = "unit" THEN "unit"
	ELSE "bulk"
	END as prod_qty_type_condensed,


--END QUERY


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
--QUERY 6
	CASE WHEN product_name like '%pepper%' THEN 1
	ELSE 0
	END as pepper_flag
FROM product

--END QUERY


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by market_date, then vendor_name.
Limit to 24 rows of output. */
--QUERY 7
SELECT *
FROM vendor
INNER JOIN vendor_booth_assignments
	ON vendor.vendor_id = vendor_booth_assignments.vendor_id 
ORDER BY market_date, vendor_name
LIMIT 24

--END QUERY



/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
--QUERY 8
SELECT vendor_id,
COUNT(booth_number)
FROM vendor_booth_assignments
GROUP BY vendor_id

--END QUERY


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
--QUERY 9
SELECT customer.customer_last_name, customer.customer_first_name
FROM customer
INNER JOIN customer_purchases
	ON customer.customer_id = customer_purchases.customer_id
GROUP BY customer.customer_id, customer.customer_last_name, customer.customer_first_name
HAVING SUM(customer_purchases.cost_to_customer_per_qty) > 2000
ORDER BY customer.customer_last_name, customer.customer_first_name

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
--QUERY 10
DROP TABLE IF EXISTS temp.new_vendor;
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;
INSERT INTO temp.new_vendor(vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES(10, "Thomas Superfood Store", "Fresh Focused store", "Thomas", "Rosenthal")

--END QUERY

/* SECTION 4 */
/* What values systems are embedded in databases and data systems you encounter in your day-to-day life?*/

/*One data system I encounter in my day-to-day life is a medical record. These records include patient information such as name, sex, marital status, work
place, place of residence, health card number, and emergency contacts (these would typically be family members). They also include medical history 
of a patient such as past immunizations, surgeries, doctor visits, lab test results, and referrals. On top of that, they record family history of 
illnesses and mental health conditions. If a doctor is unsure of why a patient has certain symptoms (sometimes the lab results and subjective description 
of patient's symptoms do not match), the doctor may visit the family history data and test the patient for those conditions that run in the family that 
closely resemble the symptoms. It is important for doctors to have access to family records of a patient to identify risks and test for them. However,
those with weak or without family ties such as orphans, would have incomplete family medical records, making it harder to identify risk factors and 
diagnose. Another interesting aspect is culture. In many cultures, certain conditions (especially related to mental health) are considered to be 
embarrassing or "not real"; for this reason, they wouldn't report this information to their doctor and the family history data would be incomplete. 
On the flip side, the doctors may also rely too much on family history information and dismiss patients' thoughts about their own condition, which
may especially be true for younger patients and recent immigrants who may struggle communicating their thoughts due to language barrier. This way, 
medical databases and social structures are intertwined.*/

