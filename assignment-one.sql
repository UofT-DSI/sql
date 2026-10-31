BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "assignment1" (
	"field1"	TEXT,
	"field2"	TEXT
);
INSERT INTO "assignment1" VALUES ('/* ASSIGNMENT 1 */',NULL);
INSERT INTO "assignment1" VALUES ('--Please write responses between the QUERY # and END QUERY blocks',NULL);
INSERT INTO "assignment1" VALUES ('/* SECTION 2 */',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--SELECT',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Write a query that returns everything in the customer table. */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 1',NULL);
INSERT INTO "assignment1" VALUES ('SELECT * 
FROM customer;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/* 2. Write a query that displays all of the columns and 10 rows from the customer table',NULL);
INSERT INTO "assignment1" VALUES ('sorted by customer_last_name','then customer_first_ name. */');
INSERT INTO "assignment1" VALUES ('--QUERY 2',NULL);
INSERT INTO "assignment1" VALUES ('SELECT * 
FROM customer
ORDER by customer_last_name, customer_first_name
LIMIT 10; ',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--WHERE',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Write a query that returns all customer purchases of product IDs 4 and 9.',NULL);
INSERT INTO "assignment1" VALUES ('Limit to 25 rows of output. */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 3',NULL);
INSERT INTO "assignment1" VALUES ('SELECT * 
FROM customer_purchases
WHERE product_id = 4 OR product_id = 9
LIMIT 25;
',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/*2. Write a query that returns all customer purchases and a new calculated column ''price'' (quantity * cost_per_quantity)',NULL);
INSERT INTO "assignment1" VALUES ('filtered by customer IDs between 8 and 10 (inclusive) using either:',NULL);
INSERT INTO "assignment1" VALUES ('1.  two conditions using AND',NULL);
INSERT INTO "assignment1" VALUES ('2.  one condition using BETWEEN',NULL);
INSERT INTO "assignment1" VALUES ('Limit to 25 rows of output.',NULL);
INSERT INTO "assignment1" VALUES ('*/',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 4',NULL);
INSERT INTO "assignment1" VALUES ('SELECT *, (quantity * cost_per_quantity) AS price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10
LIMIT 25;
',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('',NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--CASE',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz.',NULL);
INSERT INTO "assignment1" VALUES ('Using the product table','write a query that outputs the product_id and product_name');
INSERT INTO "assignment1" VALUES ('columns and add a column called prod_qty_type_condensed that displays the word “unit”',NULL);
INSERT INTO "assignment1" VALUES ('if the product_qty_type is “unit','” and otherwise displays the word “bulk.” */');
INSERT INTO "assignment1" VALUES ('--QUERY 5',NULL);
INSERT INTO "assignment1" VALUES ('SELECT product_id, product_name,
	CASE
		WHEN product_qty_type = ''unit''
			THEN ''unit''
		ELSE ''bulk''
	END as product_qty_type_condensed
FROM product;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/* 2. We want to flag all of the different types of pepper products that are sold at the market.',NULL);
INSERT INTO "assignment1" VALUES ('add a column to the previous query called pepper_flag that outputs a 1 if the product_name',NULL);
INSERT INTO "assignment1" VALUES ('contains the word “pepper” (regardless of capitalization)','and otherwise outputs 0. */');
INSERT INTO "assignment1" VALUES ('--QUERY 6',NULL);
INSERT INTO "assignment1" VALUES ('SELECT product_id, product_name,
	CASE
		WHEN product_qty_type = ''unit''
			THEN ''unit''
		ELSE ''bulk''
	END as product_qty_type_condensed,

	CASE
		WHEN lower(product_name) like ''%pepper%'' 
			THEN 1
		ELSE 0
	END as pepper_flag
FROM product;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--JOIN',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the',NULL);
INSERT INTO "assignment1" VALUES ('vendor_id field they both have in common','and sorts the result by market_date');
INSERT INTO "assignment1" VALUES ('Limit to 24 rows of output. */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 7',NULL);
INSERT INTO "assignment1" VALUES ('SELECT *
FROM vendor
INNER JOIN vendor_booth_assignments
	on vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER by 
	market_date,
	vendor_name
LIMIT 24;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/* SECTION 3 */',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('-- AGGREGATE',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Write a query that determines how many times each vendor has rented a booth',NULL);
INSERT INTO "assignment1" VALUES ('at the farmer’s market by counting the vendor booth assignments per vendor_id. */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 8',NULL);
INSERT INTO "assignment1" VALUES ('SELECT 
	vendor_id,
	count (*) as total_number_booth_rented
FROM vendor_booth_assignments
GROUP by vendor_id;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper',NULL);
INSERT INTO "assignment1" VALUES ('sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list',NULL);
INSERT INTO "assignment1" VALUES ('of customers for them to give stickers to','sorted by last name');
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('HINT: This query requires you to join two tables','use an aggregate function');
INSERT INTO "assignment1" VALUES ('--QUERY 9',NULL);
INSERT INTO "assignment1" VALUES ('SELECT 
	customer.customer_id,
	customer_last_name,
	customer_first_name,
	sum(customer_purchases.quantity * customer_purchases.cost_per_quantity) as total_spent
FROM customer_purchases
INNER JOIN customer
	on customer_purchases.customer_id = customer.customer_id
GROUP by
	customer.customer_id,
	customer_last_name,
	customer_first_name
HAVING sum(quantity * cost_per_quantity) > 2000
ORDER by 
	customer_last_name ASC,
	customer_first_name ASC;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--Temp Table',NULL);
INSERT INTO "assignment1" VALUES ('/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor:',NULL);
INSERT INTO "assignment1" VALUES ('Thomass Superfood Store','a Fresh Focused store');
INSERT INTO "assignment1" VALUES ('',NULL);
INSERT INTO "assignment1" VALUES ('HINT: This is two total queries -- first create the table from the original','then insert the new 10th vendor.');
INSERT INTO "assignment1" VALUES ('When inserting the new vendor','you need to appropriately align the columns to be inserted');
INSERT INTO "assignment1" VALUES ('(there are five columns to be inserted','I''ve given you the details');
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('-> To insert the new row use VALUES','specifying the value you want for each column:');
INSERT INTO "assignment1" VALUES ('VALUES(col1','col2');
INSERT INTO "assignment1" VALUES ('*/',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 10',NULL);
INSERT INTO "assignment1" VALUES ('CREATE TEMP TABLE temp_new_vendor as
SELECT * FROM vendor;
INSERT into temp_new_vendor
values (10, ''Thomass Superfood Store'', ''Fresh Focused'', ''Thomas'', ''Rosenthal'');',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('-- Date',NULL);
INSERT INTO "assignment1" VALUES ('/*1. Get the customer_id','month');
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month',NULL);
INSERT INTO "assignment1" VALUES ('and year are!',NULL);
INSERT INTO "assignment1" VALUES ('Limit to 25 rows of output. */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 11',NULL);
INSERT INTO "assignment1" VALUES ('SELECT
	customer_id,
	strftime(''%m'', market_date) as month,
	strftime(''%Y'', market_date) as year
FROM customer_purchases
LIMIT 25;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('/* 2. Using the previous query as a base','determine how much money each customer spent in April 2022.');
INSERT INTO "assignment1" VALUES ('Remember that money spent is quantity*cost_per_quantity.',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('HINTS: you will need to AGGREGATE','GROUP BY');
INSERT INTO "assignment1" VALUES ('but remember','STRFTIME returns a STRING for your WHERE statement...');
INSERT INTO "assignment1" VALUES ('AND be sure you remove the LIMIT from the previous query before aggregating!! */',NULL);
INSERT INTO "assignment1" VALUES ('--QUERY 12',NULL);
INSERT INTO "assignment1" VALUES ('SELECT
	customer_id,
	month,
	year,
	sum(quantity * cost_per_quantity) as total_spent
FROM (
	SELECT
		customer_id, 
		quantity,
		cost_per_quantity,
		strftime(''%m'', market_date) as month,
		strftime(''%Y'', market_date) as year
	FROM customer_purchases
)
WHERE month = ''04'' AND year = ''2022''
GROUP by customer_id
;',NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES (NULL,NULL);
INSERT INTO "assignment1" VALUES ('--END QUERY',NULL);
COMMIT;
