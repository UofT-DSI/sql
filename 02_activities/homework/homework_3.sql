-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
SELECT vendor_id, COUNT(booth_number) AS booth_rentals
FROM vendor_booth_assignments
GROUP BY vendor_id


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
SELECT c.customer_last_name, c.customer_first_name
FROM customer c
JOIN customer_purchases cp ON c.customer_id = cp.customer_id
GROUP BY c.customer_id
HAVING SUM(cp.quantity * cp.cost_to_customer_per_qty) > 2000
ORDER BY c.customer_last_name, c.customer_first_name;

-- Create temp table
CREATE TEMPORARY TABLE temp.new_vendor AS
SELECT * FROM vendor;


-- Insert new vendor
INSERT INTO temp.new_vendor (vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES ('Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

-- Get customer_id, month, and year of every purchase: 
SELECT 
    customer_id, 
    STRFTIME('%m', transaction_time) AS month, 
    STRFTIME('%Y', transaction_time) AS year
FROM 
    customer_purchases;

--- Determine money spent by each customer in April 2022:

SELECT 
    customer_id, 
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM 
    customer_purchases
WHERE 
    STRFTIME('%m', transaction_time) = '04' 
    AND STRFTIME('%Y', transaction_time) = '2022'
GROUP BY 
    customer_id;

