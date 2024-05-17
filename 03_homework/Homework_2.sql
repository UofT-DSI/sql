--Write a query that returns everything in the customer table.
SELECT * 
FROM customer;

--Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.
SELECT customer_id, customer_first_name, customer_last_name, customer_zip
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;


--Write a query that returns all customer purchases of product IDs 4 and 9.
SELECT product_id, vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty, transaction_time
FROM customer_purchases
WHERE product_id IN (4,9);

--Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
SELECT *, (quantity * cost_to_customer_per_qty) as price
FROM customer_purchases
WHERE vendor_id between 8 and 11;

--Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”
SELECT product_id, product_name, CASE when product_qty_type = "unit" then "unit" else "bulk" end as Product_qty_type_condensed
FROM product;

--We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.
SELECT product_id, product_name, CASE when product_qty_type = "unit" then "unit" else "bulk" end as Product_qty_type,
								 CASE when product_name like "% Peppers %" then 1 else 0 end as pepper_flag
FROM product;


--Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.
SELECT *
FROM vendor v inner join vendor_booth_assignments vba
ON v.vendor_id = vba.vendor_id
order by vendor_name, market_date;
								 
