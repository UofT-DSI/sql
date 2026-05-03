SELECT *
FROM customer;


SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;


SELECT *
FROM customer_purchases
WHERE product_id IN (4, 9)
LIMIT 25;


SELECT *,
		quantity * cost_to_customer_per_qty as price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10
LIMIT 25;


SELECT product_id,
       product_name,
       CASE
           WHEN product_qty_type = 'unit' THEN 'unit'
           ELSE 'bulk'
       END AS prod_qty_type_condensed
FROM product;


SELECT product_id,
       product_name,
       CASE
				WHEN product_qty_type = 'unit' then 'unit'
				ELSE 'bulk'
			END as product_qty_type_condensed,
			CASE
				WHEN lower(product_name) like '%pepper%' THEN 1
				ELSE 0
			END as pepper_flag
	FROM product;			

SELECT*
FROM vendor
INNER JOIN vendor_booth_assignments 
	ON vendor.vendor_id = vendor_booth_assignments.vendor_id
ORDER By market_date, vendor_name
LIMIT 24;
	
	
SELECT vendor_id,
		count(*)	 as booth_rental_count
FROM vendor_booth_assignments
GROUP by vendor_id;


SELECT c.customer_id,
       c.customer_first_name,
       c.customer_last_name,
       SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
FROM customer c
INNER JOIN customer_purchases cp
    ON c.customer_id = cp.customer_id
GROUP BY c.customer_id,
         c.customer_first_name,
         c.customer_last_name
HAVING SUM(cp.quantity * cp.cost_to_customer_per_qty) > 2000
ORDER BY c.customer_last_name,
         c.customer_first_name;

		 
CREATE TEMP TABLE new_vendor AS
SELECT *
FROM vendor;

INSERT INTO new_vendor
(vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES
(10, 'Samira superfood Store', 'Fresh Focused Store', 'Samira', 'Dib');


SELECT
customer_id,
				strftime ('%m', market_date) as month,
				strftime('%Y', market_date) as year
FROM customer_purchases
LIMIT 25;


SELECT
customer_id,
	sum(quantity * cost_to_customer_per_qty) as total_spent
FROM customer_purchases
WHERE strftime('%m', market_date) = '04'
	AND strftime('%Y', market_date) = '2022'
group by customer_id
