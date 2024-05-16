-- SELECT 1: Query to return everything in the customer table:

SELECT * FROM customer;

-- SELECT 2: Query to display all ten columns and ten rows from the customer table, sorted by customer_last_name and then customer_first_name:

SELECT * 
FROM customer 
ORDER BY customer_last_name, customer_first_name 
LIMIT 10;


-- WHERE 1: Query to return all customer purchases of product IDs 4 and 9:

SELECT * 
FROM customer_purchases 
WHERE product_id IN (4, 9);


-- WHERE 2a: Query to return all customer purchases and a new calculated column 'price', filtered by vendor IDs between 8 and 10 using AND:

SELECT *, (quantity * cost_to_customer_per_qty) AS price 
FROM customer_purchases 
WHERE vendor_id >= 8 AND vendor_id <= 10;


-- WHERE 2b: Query to return all customer purchases and a new calculated column 'price', filtered by vendor IDs between 8 and 10 using BETWEEN:

SELECT *, (quantity * cost_to_customer_per_qty) AS price 
FROM customer_purchases 
WHERE vendor_id BETWEEN 8 AND 10;


-- CASE 1: Query to output product_id, product_name, and add a column called prod_qty_type_condensed:

SELECT product_id, product_name, 
CASE 
    WHEN product_qty_type = 'unit' THEN 'unit' 
    ELSE 'bulk' 
END AS prod_qty_type_condensed 
FROM product;


-- CASE 2: Query to add a column called pepper_flag:

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


-- JOIN: Query to INNER JOIN the vendor table to the vendor_booth_assignments table on the vendor_id field and sort by vendor_name, then market_date:

SELECT *
FROM vendor
INNER JOIN vendor_booth_assignments
ON vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER BY vendor.vendor_name, vendor_booth_assignments.market_date;

