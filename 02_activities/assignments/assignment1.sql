/*SELECT
1. Write a query that returns everything in the customer table.*/
SELECT* FROM customer

/*2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.*/
SELECT* 
FROM customer
WHERE customer_id BETWEEN 1 AND 10
ORDER BY customer_last_name ASC,
         customer_first_name ASC;

/*WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9.*/
SELECT* 
FROM customer_purchases
WHERE product_id IN('4','9');

/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN*/
SELECT* 
,quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN '8' AND '10'

/*CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”

2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.*/

SELECT product_id,product_name,
CASE WHEN product_qty_type = 'unit'
		THEN 'UNIT'
	ELSE 'BULK'
END prod_qty_type_condensed,
CASE WHEN product_name like '%pepper%'
		THEN '1'
	ELSE '0'
END pepper_flag	
FROM product

/*JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.*/

SELECT*
FROM vendor
INNER JOIN vendor_booth_assignments
	ON vendor.vendor_id=vendor_booth_assignments.vendor_id
ORDER BY vendor_name ASC,
		market_date ASC;

/*AGGREGATE
1. Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.*/

SELECT
vendor_id,
count(booth_number) AS num_times_rented
FROM vendor_booth_assignments
GROUP by vendor_id;

/*2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name.*/
SELECT
customer_first_name,customer_last_name,
sum(quantity*cost_to_customer_per_qty) as total_cost
FROM customer_purchases cp
INNER JOIN customer c
	ON cp.customer_id=c.customer_id
GROUP by c.customer_id
HAVING sum(quantity*cost_to_customer_per_qty)>2000

/*Temp Table
1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal*/

DROP TABLE if EXISTS temp_new_vendor;
CREATE TEMP TABLE temp_new_vendor as
SELECT*
FROM vendor;
INSERT INTO temp_new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES ('10', 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');
SELECT* FROM temp_new_vendor

/*Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
   
**HINT**: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are!*/

SELECT
customer_id,
strftime('%m', market_date) as "Month",
strftime('%Y', market_date) as "Year"
FROM customer_purchases

/*2. Using the previous query as a base, determine how much money each customer spent in April 2022. Remember that money spent is `quantity*cost_to_customer_per_qty`.
   
**HINTS**: you will need to AGGREGATE, GROUP BY, and filter...but remember, STRFTIME returns a STRING for your WHERE statement!!*/

SELECT
customer_id,
strftime('%m', market_date) as "Month",
strftime('%Y', market_date) as "Year",
sum(quantity*cost_to_customer_per_qty) as money_spent
FROM customer_purchases
GROUP by market_date
HAVING Month = '04' AND Year = '2022'