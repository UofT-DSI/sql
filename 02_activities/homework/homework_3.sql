-- booth assignments
SELECT vendor_id, COUNT(*) AS booth_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

-- spent greater than $2000
SELECT c.customer_id, c.customer_first_name, c.customer_last_name, SUM(p.quantity * p.cost_to_customer_per_qty) AS total_spent
FROM customer AS c
JOIN customer_purchases AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING total_spent > 2000
ORDER BY c.customer_last_name, c.customer_first_name;

-- temp table 
CREATE TEMP TABLE temp.new_vendor AS
SELECT * FROM vendor;

-- new vendor
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, owner_name, other_info)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas Rosenthal', 'Some Info');

-- month/year of purchases
SELECT customer_id, STRFTIME('%m', purchase_date) AS month, STRFTIME('%Y', purchase_date) AS year
FROM customer_purchases;

-- total spending 04.22
SELECT customer_id, SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE STRFTIME('%m', purchase_date) = '04' AND STRFTIME('%Y', purchase_date) = '2022'
GROUP BY customer_id;
