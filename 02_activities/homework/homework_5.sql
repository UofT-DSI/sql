-- This I wrote to better understand what is actually happening

SELECT  vendor_inventory.vendor_id, vendor.vendor_name, vendor_inventory.product_id, product.product_name, customer.customer_id, 5 * vendor_inventory.original_price
FROM vendor_inventory
JOIN vendor ON	vendor_inventory.vendor_id = vendor.vendor_id
JOIN product ON product.product_id = vendor_inventory.product_id
CROSS JOIN customer
ORDER BY vendor_inventory.vendor_id;

-- and this is what is expected, almost the same thing as above but without the extra columns and with the sum aggregation.

SELECT  vendor.vendor_name, product.product_name, SUM(5 * vendor_inventory.original_price) as revenue
FROM vendor_inventory
JOIN vendor ON	vendor_inventory.vendor_id = vendor.vendor_id
JOIN product ON product.product_id = vendor_inventory.product_id
CROSS JOIN customer
GROUP BY vendor.vendor_name, product.product_name;


DROP TABLE IF EXISTS product_units;
CREATE TABLE product_units AS
SELECT 
product_id,
product_name,
product_size, 
product_category_id,
product_qty_type,
CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

INSERT INTO product_units
VALUES ( 7, 'Apple Pie', '7"', 3, 'unit', CURRENT_TIMESTAMP);

DELETE FROM product_units
WHERE product_id = 7
AND product_size = '7"';

ALTER TABLE product_units
ADD current_quantity INT;

-- for finding the last quantity we can find the row with maximum time for each product

SELECT pu.product_id, pu.product_name, vi.quantity, vi.market_date
FROM product_units pu
LEFT JOIN (
	SELECT product_id, quantity, market_date
	FROM vendor_inventory
	WHERE (product_id, market_date) IN (
		SELECT product_id, MAX(market_date)
		FROM vendor_inventory
		GROUP BY product_id
		)
	) vi
ON pu.product_id = vi.product_id;

-- UPDATE product_units
-- SET current_quantity = (
-- 	SELECT COALESCE(vendor_inventory.quantity, 0)
-- 	FROM vendor_inventory
-- 	WHERE product_units.product_id = vendor_inventory.product_id
-- 	AND vendor_inventory.market_date = (
-- 		SELECT MAX(vendor_inventory.market_date)
-- 		FROM vendor_inventory
-- 		WHERE vendor_inventory.product_id = product_units.product_id
-- 		)
-- 	)

UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(vi.quantity, 0) 
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    AND vi.market_date = (
        SELECT MAX(vi2.market_date)
        FROM vendor_inventory vi2
        WHERE vi2.product_id = product_units.product_id
    )
);

-- It seems that my coalesce is not working tho, as I have Null values in my table, needs troubleshooting

