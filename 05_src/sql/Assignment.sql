-- -----------------ASSIGNMENT SECTION 2-------------------------

--SELECT Q1
SELECT * FROM customer;


--SELECT Q2
SELECT * FROM customer
ORDER BY customer_last_name , customer_first_name
LIMIT 10;

--WHERE Q1
SELECT * FROM customer_purchases
WHERE product_id IN (4,9);

--WHERE Q2
SELECT * , quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

--CASE Q1
SELECT product_id, product_name, 

CASE WHEN product_qty_type ='unit' THEN 'unit'
	ELSE 'bulk'
END as prod_qty_type_condensed

FROM product;

--CASE Q2
SELECT * , quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

SELECT product_id, product_name, 
CASE WHEN product_name LIKE '%pepper%' THEN 1
	ELSE 0
END as pepper_flag 

FROM product;


-- JOIN Q1
SELECT vendor_name, market_date FROM vendor
INNER JOIN vendor_booth_assignments
ON vendor.vendor_id = vendor_booth_assignments.vendor_id
-- added sorting after @monzchan comment on assignment 1
ORDER BY vendor_name,market_date; 


-- -----------------ASSIGNMENT SECTION 3-------------------------

-- AGGREGATE Q1
SELECT vendor_id, COUNT(vendor_id) as total_count 
FROM vendor_booth_assignments 
GROUP by vendor_id;

-- AGGREGATE Q2
SELECT customer_first_name, 
customer_last_name, 
SUM(quantity* cost_to_customer_per_qty) as total_purchase FROM customer
INNER JOIN customer_purchases
ON customer.customer_id = customer_purchases.customer_id
GROUP by customer_first_name, customer_last_name
HAVING total_purchase > 2000 ;

--TEMP TABLE
DROP TABLE IF EXISTS TEMP.new_vendor;
CREATE TABLE temp.new_vendor AS
SELECT * FROM vendor;

INSERT INTO temp.new_vendor
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

--DATE Q1
SELECT 
    customer_id,
    strftime('%m', market_date) AS month,
    strftime('%Y', market_date) AS year
FROM customer_purchases;

--DATE Q2
SELECT 
	c.customer_first_name, 
	c.customer_last_name, 
	SUM(cp.quantity* cp.cost_to_customer_per_qty) AS total_spent, 
    strftime('%m', cp.market_date) AS month,
    strftime('%Y', cp.market_date) AS year
FROM customer AS c
INNER JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE strftime('%Y', cp.market_date) = '2022'
  AND strftime('%m', cp.market_date) = '04'
GROUP BY c.customer_first_name, c.customer_last_name, month;
