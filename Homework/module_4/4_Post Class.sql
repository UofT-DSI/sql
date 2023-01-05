--Date
/* 1. Using the customer_purchases table and STRFTIME select and group by the weekday and hour of the day, 
and count the distinct number of customers during each hour of the Wednesday and Saturday markets. 
HINT: the first STRFTIME will _not_ be day */


/* 2. **CHALLENGING!** Using two case statment add the day of the week name (0 = "Sunday", 1 = "Monday" etc) 
and change the transaction hour to Morning or Afternoon (< 12 = Morning, else Evening) to the previous query. 
Fix the group by to correctly calculate which period sold the most (3 rows total). */



-- String manipulations
/* 1. Some product names in the product table have descriptions like "Jar" or "Organic". 
These are separated from the product name with a hyphen. 
Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. 
Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

Hint: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. */



/* 2. FIlter the query to show any product_size value that contain a number with REGEXP. */


--Cross Join
/*1. Suppose every customer on record bought each item the vendor has in their inventory (for a single day). 
How much money would each vendor make per product? 
Show this by vendor_name (concatenate first and last) and product name, rather than using the IDs. */



/* 2. What if we want to include every day the market is open? Modify the query to show how much each vendor could make. */