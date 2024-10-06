-- AGGREGATE

-- SELECT vendor_id, COUNT(*) AS booth_rentals
-- FROM vendor_booth_assignments
-- GROUP BY vendor_id;

-- SELECT c.customer_id, c.customer_last_name, c.customer_first_name, SUM(p.quantity * p.cost_to_customer_per_qty) AS total_spent
-- FROM customer AS c
-- JOIN customer_purchases AS p ON c.customer_id = p.customer_id
-- GROUP BY c.customer_id, c.customer_last_name, c.customer_first_name
-- HAVING total_spent > 2000
-- ORDER BY c.customer_last_name, c.customer_first_name;


-- Temp Table 

-- CREATE TEMP TABLE temp.new_vendor AS
-- SELECT * FROM vendor;

-- INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name) 
-- VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas Rosenthal', 'Healthy foods and superfoods');

-- Date 

-- SELECT customer_id, 
--        STRFTIME('%m', market_date) AS purchase_month, 
--        STRFTIME('%Y', market_date) AS purchase_year
-- FROM customer_purchases;

-- SELECT customer_id, SUM(quantity * cost_to_customer_per_qty) AS total_spent
-- FROM customer_purchases
-- WHERE STRFTIME('%m', market_date) = '04' 
-- AND STRFTIME('%Y', market_date) = '2022'
-- GROUP BY customer_id;
