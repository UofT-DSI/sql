--Cross Join 
--1.
SELECT v.vendor_name, p.product_name, SUM(5 * vi.original_price) AS total_sales_per_product
FROM 
    vendor_inventory vi
CROSS JOIN 
    (SELECT DISTINCT customer_id FROM customer) c
JOIN 
    vendor v 
    ON vi.vendor_id = v.vendor_id 
JOIN 
    product p
	ON vi.product_id = p.product_id
GROUP BY 
     v.vendor_name, p.product_name;
	 
--INSERT
--1.
CREATE TEMP TABLE product_units AS 
		SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
		FROM product
		WHERE product_qty_type = 'unit';
		
--2.
INSERT INTO product_units
values(10, 'Eggs', '1 dozen', 6, 'unit',CURRENT_TIMESTAMP);

--DELETE
--1.
DELETE 
FROM product_units
WHERE snapshot_timestamp = '2024-09-21 15:55:23';

--UPDATE
--1.
ALTER TABLE product_units
ADD current_quantity INT;

UPDATE product_units
SET current_quantity = 0;

WITH vi AS (
    SELECT 
        product_id, 
        quantity,
        RANK() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS latency
    FROM 
        vendor_inventory
),

vi_latest AS (
    SELECT 
        product_id, 
        quantity 
    FROM 
        vi
    WHERE 
        latency = 1
)

UPDATE 
    product_units
SET 
    current_quantity = (
        SELECT COALESCE(vi_latest.quantity, product_units.current_quantity)
        FROM vi_latest
        WHERE product_units.product_id = vi_latest.product_id
    )
WHERE EXISTS (
    SELECT 1
    FROM vi_latest
    WHERE product_units.product_id = vi_latest.product_id
);


