-- cross join, total sales per product 
WITH vendor_product_sales AS (
    SELECT 
        v.vendor_name,
        p.product_name,
        5 * vi.original_price * COUNT(c.customer_id) AS total_sales
    FROM vendor_inventory vi
    JOIN vendor v ON vi.vendor_id = v.vendor_id
    JOIN product p ON vi.product_id = p.product_id
    CROSS JOIN customer c
    GROUP BY v.vendor_name, p.product_name, vi.original_price
)
SELECT vendor_name, product_name, total_sales
FROM vendor_product_sales;

-- create table containing unit products
CREATE TABLE IF NOT EXISTS product_units AS
SELECT 
    p.*,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product p
WHERE p.product_qty_type = 'unit';

-- new row 
INSERT INTO product_units (product_id, product_name, product_qty_type, price_per_unit, snapshot_timestamp)
VALUES (1001, 'New Apple Pie', 'unit', 10.99, CURRENT_TIMESTAMP);

-- delete the old record
DELETE FROM product_units
WHERE product_id = 1001
AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp)
    FROM product_units
    WHERE product_id = 1001
);

-- add column to product_units
ALTER TABLE product_units
ADD current_quantity INT;

-- update current_quantity w/ last quantity from vendor_inventory
WITH latest_vendor_inventory AS (
    SELECT
        vi.product_id,
        COALESCE(MAX(vi.quantity), 0) AS last_quantity
    FROM vendor_inventory vi
    GROUP BY vi.product_id
)
UPDATE product_units pu
SET current_quantity = (
    SELECT last_quantity
    FROM latest_vendor_inventory lvi
    WHERE lvi.product_id = pu.product_id
)
WHERE EXISTS (
    SELECT 1
    FROM latest_vendor_inventory lvi
    WHERE lvi.product_id = pu.product_id
);
