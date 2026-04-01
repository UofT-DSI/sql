SELECT DISTINCT
vendor_name, product_name, customer_first_name, customer_last_name
FROM customer_purchases as cp
INNER JOIN vendor as v
	ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
	ON p.product_id = cp.product_id
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id;
	
SELECT COUNT(product_id) as num_of_products
FROM product;

CREATE TABLE temp.new_vendor_inventory AS

-- definition of the table
SELECT *,
original_price*5 as inflation
FROM vendor_inventory

SELECT * FROM temp.new_vendor_inventory


