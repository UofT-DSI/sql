--  Write a query that returns everything in the customer table.

SELECT * FROM customer;

-- 2 Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

-- 3) Write a query that returns all customer purchases of product IDs 4 and 9.
SELECT *
FROM customer_purchases
WHERE product_id IN	(4,9);

-- 4) Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either: 1.  two conditions using AND 2.  one condition using BETWEEN

SELECT *, (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE vendor_id >= 8 and vendor_id <=10;

-- 5) 	products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”
SELECT product_id, product_name, 
CASE WHEN product_qty_type = 'unit' THEN 'unit'
 ELSE 'bulk'
 END AS `prod_qty_type_condensed`
FROM product;

-- 6) We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.

SELECT product_id, product_name, 
CASE WHEN product_qty_type = 'unit' THEN 'unit'
 ELSE 'bulk'
 END AS `prod_qty_type_condensed`,
 CASE WHEN product_name like '%pepper%' THEN 1
 ELSE 0
 END AS 'pepper_flag'
FROM product;

-- 7)  Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.
select *
FROM vendor
INNER JOIN vendor_booth_assignments
ON	vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER BY vendor_name, market_date;

-- 8) Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.
SELECT
vendor_id,
count(*) as assignment_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

-- 9)The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name.

SELECT a.customer_id,a.customer_last_name,a.customer_first_name,sum(b.quantity * b.cost_to_customer_per_qty) as revenue
FROM customer as a
INNER JOIN customer_purchases as b
ON a.customer_id = b.customer_id
GROUP BY a.customer_id, a.customer_last_name, a.customer_first_name
HAVING revenue > 2000
ORDER BY a.customer_last_name, a.customer_first_name;

-- 10) Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
DROP TABLE IF EXISTS temp.new_vendor;
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;
INSERT INTO temp.new_vendor
  (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES
  (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');
  
--11)
SELECT
  customer_id,
  strftime('%m', market_date) AS month,
  strftime('%Y', market_date) AS year
FROM customer_purchases;

--2) 
SELECT
  customer_id,
  SUM(quantity * cost_to_customer_per_qty) AS spent_i0422
FROM customer_purchases
WHERE strftime('%m', market_date) = '04'
  AND strftime('%Y', market_date) = '2022'
GROUP BY customer_id;






