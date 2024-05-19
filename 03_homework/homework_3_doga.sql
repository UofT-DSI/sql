--1)Aggregate

SELECT vendor_id, COUNT(*) AS vendor_booth_assignments
FROM vendor_booth_assignments
GROUP BY vendor_id;

--2) 
SELECT 
    customer.customer_id,  
    customer.customer_last_name,
    customer.customer_first_name,
    SUM(quantity * cost_to_customer_per_qty) AS total_spend_per_customer_id
FROM 
    customer
INNER JOIN 
    customer_purchases 
ON 
    customer.customer_id = customer_purchases.customer_id
GROUP BY 
    customer.customer_id,  
    customer.customer_last_name,
    customer.customer_first_name
HAVING 
    total_spend_per_customer_id > 2000
ORDER BY 
    customer.customer_last_name, 
    customer.customer_first_name;

--1) Temp Table
    SELECT vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name
    FROM vendor;
INSERT INTO new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

SELECT * FROM new_vendor

--1)# Date
SELECT 
    customer_id,
    (quantity * cost_to_customer_per_qty) AS total_spend_per_customer_id,
    strftime('%m', customer_purchases.market_date) AS month,
    strftime('%Y', customer_purchases.market_date) AS year
FROM  
    customer_purchases 
WHERE
    strftime('%m', customer_purchases.market_date) = '04'
    AND strftime('%Y', customer_purchases.market_date) = '2019';