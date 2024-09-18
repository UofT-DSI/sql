/* AGGREGATE
	a) Write a query that determines how many times each vendor 
	has rented a booth at the farmer’s market by counting the 
	vendor booth assignments per vendor_id.*/

SELECT vendor_id, COUNT (booth_number) AS booth_count
FROM vendor_booth_assignments
GROUP BY vendor_id
    
/*	b) The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker 
	to everyone who has ever spent more than $2000 at the market. 
	Write a query that generates a list of customers for them to give stickers to, 
	sorted by last name, then first name. 
	HINT: This query requires you to join two tables, 
	use an aggregate function, and use the HAVING keyword.*/

SELECT cust.customer_first_name, cust.customer_last_name, SUM(cp.quantity*cp.cost_to_customer_per_qty)
FROM customer cust JOIN customer_purchases cp
ON cust.customer_id = cp.customer_id
GROUP BY cust.customer_id
HAVING SUM(cp.quantity*cp.cost_to_customer_per_qty) > 2000
ORDER BY cust.customer_last_name, cust.customer_first_name

/*TEMP TABLE
	Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
	Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal HINT: 
	This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
	When inserting the new vendor, you need to appropriately align the columns to be inserted 
	(there are five columns to be inserted, I've given you the details, but not the syntax)
    To insert the new row use VALUES, specifying the value you want for each column:
    VALUES(col1,col2,col3,col4,col5)*/

DROP TABLE IF EXISTS temp.new_vendor;
CREATE TEMP TABLE temp.new_vendor AS
SELECT * FROM vendor;
INSERT INTO temp.new_vendor (vendor_id,vendor_name,vendor_type, vendor_owner_first_name, vendor_owner_last_name) 
VALUES('10','Thomass Superfood Store','Fresh Focused','Thomass','Rosenthal')


/*DATE
    Get the customer_id, month, and year (in separate columns) of every purchase 
	in the customer_purchases table. HINT: you might need to search for strfrtime modifers 
	sqlite on the web to know what the modifers for month and year are!*/
	
SELECT customer_id, 
strftime('%m', market_date) as Month, 
strftime('%Y', market_date) as Year 
FROM customer_purchases;
	
/*    Using the previous query as a base, determine how much money each customer spent in April 2022. 
	Remember that money spent is quantity*cost_to_customer_per_qty. 
	HINTS: you will need to AGGREGATE, GROUP BY, and filter...but remember, 
	STRFTIME returns a STRING for your WHERE statement!!*/
	
SELECT customer_id, SUM(quantity*cost_to_customer_per_qty) AS spent_in_april_2022 
FROM customer_purchases
WHERE strftime('%Y', market_date) = '2022'
AND strftime('%m', market_date) = '04'
GROUP BY customer_id;
	