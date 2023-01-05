--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) */

--Windowed Functions
/* 1. Write a query that selects from the customer_purchases table and numbers each customer’s  
visits to the farmer’s market (labeling each market date with a different number). 
Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on
each new market date for each customer, or select only the unique market dates per customer 
(without purchase details) and number those visits. 
HINT: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK(). */


/* 2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, 
then write another query that uses this one as a subquery (or temp table) and filters the results to 
only the customer’s most recent visit. */


/* 3. Using a COUNT() window function, include a value along with each row of the 
customer_purchases table that indicates how many different times that customer has purchased that product_id. */


/*4. (we'll do this one together)
Using `SUM(COUNT(*)) OVER(...)` create two running totals: 
one for each cutomer for each product, and one for each customer. Use the previous query as a baseline. */


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are! */


/* 2. What if we wanted to add each purchase month as another windowed group from previous our rolling totals query? */


-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

	SELECT 
	product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
	FROM product

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first problem, and 'unit' for the second problem. 

(Hint, keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. Edit the appropriate columns -- you're making two edits -- 
and the NULL rows will be fixed. All the other rows will remain the same.) */

