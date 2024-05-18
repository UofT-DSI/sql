--Aggregate Query: Counting Vendor Booth Assignments
SELECT vendor_id, COUNT(*) AS booth_assignment_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

--Aggregate Query: Customers Spending More Than $2000
SELECT c.customer_id, c.customer_first_name, c.customer_last_name, SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
FROM customer c
JOIN customer_purchases cp ON c.customer_id = cp.customer_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_last_name
HAVING total_spent > 2000
ORDER BY c.customer_last_name, c.customer_first_name;

--Temp Table: Insert New Vendor
CREATE TEMPORARY TABLE new_vendor AS
SELECT *
FROM vendor;

INSERT INTO new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

--Date Query: Extract Month and Year
SELECT customer_id, strftime('%m', market_date) AS month, strftime('%Y', market_date) AS year
FROM customer_purchases;

--Date Query: Customer Spending in April 2019
SELECT customer_id, SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE strftime('%m', market_date) = '04' AND strftime('%Y', market_date) = '2019'
GROUP BY customer_id;
--FREDY RINCON
--uoft-dsi-c3-homework_3-20240517
--uoft-dsi-c3-sql_homework_3-20240517
