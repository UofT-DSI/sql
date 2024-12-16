/* ASSIGNMENT 1 Fiona He*/
/* SECTION 2 */


--SELECT
/* 1. Write a query that returns everything in the customer table. */

select * from customer

/* 2. Write a query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */
select * from customer
order by customer_last_name, customer_first_name
limit 10


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1
select
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty as price
from customer_purchases
-- option 2



/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1

select
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty as price
from customer_purchases
where vendor_id >= 8
and vendor_id <= 10

-- option 2
select
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty as price
from customer_purchases
where vendor_id between 8 and 10
order by market_date, vendor_id, product_id
-- option 2


--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */
select
product_id,
product_name,
case when product_qty_type = "unit" then "unit"
else "bulk" end as prod_qty_type_condensed
from product


/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
select
product_id,
product_name,
case when product_name like '%epper%'
then 1 else 0 end as pepper_flag
from product


--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */

select *
from vendor as v
inner join vendor_booth_assignments as vba
    on v.vendor_id = vba.vendor_id
order by v.vendor_name, vba.market_date


/* SECTION 3 */

-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
select
vendor_id,
count(*) as count_of_booth_assignments
from vendor_booth_assignments
group by vendor_id


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */



--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/
select
cp.customer_id,
c.customer_first_name,
c.customer_last_name,
sum(quantity * cost_to_customer_per_qty) as total_spent

from customer c
left join customer_purchases cp
    on c.customer_id = cp.customer_id

group by
cp.customer_id,
c.customer_first_name,
c.customer_last_name

having total_spent > 2000

order by c.customer_last_name, c.customer_first_name


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */
select customer_id,
strftime('%m',market_date) as purchase_month,
strftime('%Y', market_date) as purchase_year

from customer_purchases


/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */
select customer_id,
strftime('%m',market_date) as purchase_month,
strftime('%Y', market_date) as purchase_year,
sum(quantity*cost_to_customer_per_qty)

from customer_purchases

where STRFTIME('%Y', market_date)  = '2023'
and STRFTIME('%m',market_date) = '04'

group by STRFTIME('%Y', market_date) ,STRFTIME('%m', market_date), customer_id
