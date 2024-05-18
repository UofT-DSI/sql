

-- HOMEWORK2----
--1. (SELECT) 
select * from customer
--2. (SELECT)
select * from customer 
order by customer_last_name, customer_first_name limit 10

--3.(WHERE) Write a query that returns all customer purchases of product IDs 4 and 9
Select * from customer_purchases 
where product_id=4 or product_id=9 

--4.(WHERE) Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
--two conditions using AND
--one condition using BETWEEN
Select *, (quantity*cost_to_customer_per_qty) as price from customer_purchases
Where vendor_id BETWEEN 8 AND 10

--5.(CASE) Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the product_id and product_name columns and add a column called prod_qty_type_condensed that displays the word “unit” if the product_qty_type is “unit,” and otherwise displays the word “bulk.”

select product_id,product_name, 
CASE  product_qty_type 
	WHEN 'unit' then 'unit'
	Else 'bulk'
END prod_qty_type_condensed
from product

--6.(CASE) We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called pepper_flag that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.
select product_id,product_name, 
CASE  product_qty_type 
	WHEN 'unit' then 'unit'
	Else 'bulk'
END prod_qty_type_condensed, 

CASE  
	WHEN product_name like '%pepper%' then 1
	Else 0
END
pepper_flag
from product

--7(JOIN).Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the vendor_id field they both have in common, and sorts the result by vendor_name, then market_date.

select * from vendor
inner join vendor_booth_assignments
on vendor.vendor_id=vendor_booth_assignments.vendor_id 
order by vendor_name, market_date


