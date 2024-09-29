-- Cross Join
SELECT v.vendor_name, p.product_name, 
SUM(5 * p.price) AS total_sales
FROM (SELECT vendor_name, product_id FROM vendor_inventory) v
CROSS JOIN (SELECT product_id, product_name, price FROM product) p
CROSS JOIN (SELECT customer_id FROM customers) c
WHERE v.product_id = p.product_id
GROUP BY v.vendor_name, p.product_name;


-- INSERT
CREATE TABLE product_units AS
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

INSERT INTO product_units (product_id, product_name, product_size, product_qty_type, price, snapshot_timestamp)
VALUES (101, 'Apple Pie', 'Large', 'unit', 15.99, CURRENT_TIMESTAMP);


-- DELETE
DELETE FROM product_units
WHERE product_id = 101
AND snapshot_timestamp < (SELECT MAX(snapshot_timestamp) FROM product_units WHERE product_id = 101);


-- UPDATE
ALTER TABLE product_units
ADD current_quantity INT;

UPDATE product_units pu
SET current_quantity = (
    SELECT COALESCE(vi.quantity, 0) 
    FROM vendor_inventory vi
    WHERE vi.product_id = pu.product_id
    ORDER BY vi.inventory_date DESC
    LIMIT 1
)
WHERE EXISTS (
    SELECT 1 FROM vendor_inventory vi
    WHERE vi.product_id = pu.product_id
);
