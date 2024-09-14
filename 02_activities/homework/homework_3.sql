-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT 
	vendor_id, 
	COUNT(*) AS rentals_count
FROM 
	vendor_booth_assignments
GROUP BY 
	vendor_id;
		

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT 
	customer.customer_id,
	customer.customer_first_name,
	customer.customer_last_name,
	--customer_purchases.customer_id, --> for double-checking purposes 
	--customer_purchases.quantity, --> for double-checking purposes 
	--customer_purchases.cost_to_customer_per_qty, --> for double-checking purposes 
	SUM (customer_purchases.quantity * customer_purchases.cost_to_customer_per_qty) AS total_spend -- the WHERE clause cannot be used with aggregate functions like SUM(), COUNT(), AVG(). We need to use HAVING clause here. 
FROM 
	customer
INNER JOIN 
	customer_purchases -- since we only want the customers with total spent >$2000 
		ON 
		customer.customer_id = customer_purchases.customer_id
GROUP BY 
	customer_purchases.customer_id -- alternatively: customer.customer_id 
HAVING
	total_spend > 2000
ORDER BY 
	customer.customer_last_name,
	customer.customer_first_name;
	
		

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

CREATE TEMP TABLE new_vendor AS 
SELECT * 
FROM vendor;


INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');


SELECT * FROM new_vendor;

-- DROP TABLE IF EXISTS new_vendor --> code to delete my previously created tables


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT 
    customer_id, 
    strftime('%m', market_date) AS month, 
    strftime('%Y', market_date) AS year
FROM 
    customer_purchases;

	
	
/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT 
    customer_id, 
	strftime('%m', market_date) AS month,
	strftime('%Y', market_date) AS year,
	SUM(quantity * cost_to_customer_per_qty) AS total_spend -- AGGREGATE clause
FROM 
    customer_purchases
WHERE 
	strftime('%m', market_date) = '04' AND strftime('%Y', market_date) = '2022'
GROUP BY 
    customer_id;
