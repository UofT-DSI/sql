-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */


/* 2. Using your cherry pie query, show how much money each customer has spent on cherry pies. */


/* 3. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $50 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 
(HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.) */

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) */


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are! */


/* 2. What if we wanted to add each purchase month as another windowed group from previous our rolling totals query? */
