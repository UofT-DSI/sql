# Homework 2: Basic SQL 

-  	Due on Friday, May 17 at 11:59pm
-  	Weight: 8% of total grade
-  	Upload one .sql file with your queries

# SELECT
1. Write a query that returns everything in the customer table.
Select * 
From customer

2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.
Select * 
From customer 
Order by customer_last_name, customer_first_name  limit 10

# WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9.
Select * 
From customer_purchases 
Where product_id in (4,9)

2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	Select *, (quantity * cost_to_customer_per_qty) as price From customer_purchases Where vendor_id >= 8 and vendor_id <= 10;
	2.  one condition using BETWEEN
	Select *, (quantity * cost_to_customer_per_qty) as price From customer_purchases Where vendor_id between 8 and 10;

# CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”
Select *, 
 Case 
  When product_qty_type = 'unit' Then 'unit' 
  ELSE 'bulk' 
 End as prod_qty_type_condensed 
From  product;

2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.
Select *,
 Case 
  When product_qty_type = 'unit' Then 'unit' 
  ELSE 'bulk' 
 End as prod_qty_type_condensed,
 Case 
  When product_name like '%pepper%' Then 1 
  ELSE 0 
 End as pepper_flag
From  product;

# JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.
Select *
From vendor v 
Join vendor_booth_assignments b ON v.vendor_id = b.vendor_id
Order by vendor_name, market_date;
