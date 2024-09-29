SELECT * FROM customer;

-- display all columns and 10 rows, sorted by last name, first name 
SELECT * FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

-- all customer purchases; product ID 4 and 9
SELECT * FROM customer_purchases
WHERE product_id IN (4, 9);


-- customer purchases with a price column, by vendor b/w * and 10
SELECT *, quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

-- product qty type condensed 
SELECT product_id, product_name,
       CASE 
           WHEN product_qty_type = 'unit' THEN 'unit'
           ELSE 'bulk'
       END AS prod_qty_type_condensed
FROM product;

-- flag for products with 'pepper'
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

-- Inner join
SELECT vendor.*, vendor_booth_assignments.*
FROM vendor
INNER JOIN vendor_booth_assignments 
ON vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER BY vendor.vendor_name, vendor_booth_assignments.market_date;

