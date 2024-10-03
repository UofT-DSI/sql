--No 1. Write a query that returns everything in the customer table.--
SELECT * 
FROM customer;
-- Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.--
SELECT * 
FROM customer 
ORDER BY customer_last_name, customer_first_name 
LIMIT 10;

-- WHERE Queries
-- a. Query that returns all customer purchases of product IDs 4 and 9:
SELECT * 
FROM customer_purchases
WHERE product_id IN (4, 9);

-- b. Query that returns all customer purchases and a new calculated column price (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (using two conditions with AND):
SELECT *, (quantity * cost_to_customer_per_qty) AS price 
FROM customer_purchases 
WHERE vendor_id >= 8 AND vendor_id <= 10;

-- 3. CASE Queries
-- a. Query that outputs product_id, product_name, and a column prod_qty_type_condensed that displays "unit" if product_qty_type is "unit", otherwise displays "bulk":
SELECT product_id, product_name, 
       CASE 
           WHEN product_qty_type = 'unit' THEN 'unit' 
           ELSE 'bulk' 
       END AS prod_qty_type_condensed
FROM product;

-- b. Query that adds a pepper_flag column that outputs 1 if product_name contains the word "pepper", and otherwise outputs 0:
SELECT product_id, product_name, 
       CASE 
           WHEN product_qty_type = 'unit' THEN 'unit' 
           ELSE 'bulk' 
       END AS prod_qty_type_condensed,
       CASE 
           WHEN LOWER(product_name) LIKE '%pepper%' THEN 1 
           ELSE 0 
       END AS pepper_flag
FROM product;

-- 4. JOIN Queries
-- a. Query that INNER JOINs the vendor table to the vendor_booth_assignments table on vendor_id, and sorts by vendor_name, then market_date:
SELECT * 
FROM vendor 
INNER JOIN vendor_booth_assignments 
ON vendor.vendor_id = vendor_booth_assignments.vendor_id 
ORDER BY vendor_name, market_date;

