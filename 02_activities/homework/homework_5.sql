--- Cross Join 
WITH product_customer_combinations AS (
  SELECT v.vendor_name, p.product_name, p.product_id, original_price
  FROM vendor_inventory vi
  JOIN vendor v ON vi.vendor_id = v.vendor_id
  JOIN product p ON vi.product_id = p.product_id
  CROSS JOIN customer c
)
SELECT vendor_name, 
       product_name, 
       COUNT(*) * 5 AS total_quantity_sold,
       SUM(original_price * 5) AS total_revenue
FROM product_customer_combinations
GROUP BY vendor_name, product_name
ORDER BY vendor_name, total_revenue DESC;

---Create the "product_units" table:
CREATE TABLE product_units AS
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

----Insert a new row into the "product_units" table:
INSERT INTO product_units (
  product_id,
  product_name,
  product_size,
  product_qty_type,
  product_category_id,
  snapshot_timestamp
)
VALUES (
  (SELECT MAX(product_id) + 1 FROM product_units),
  'Apple Pie',
  '9 inch',
  'unit',
  (SELECT product_category_id FROM product_category WHERE product_category_name = 'Baked Goods'),
  CURRENT_TIMESTAMP
);

---- Delete 
DELETE FROM product_units
WHERE product_name = 'Apple Pie'
  AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp)
    FROM product_units
    WHERE product_name = 'Apple Pie'
  );

  ---- Update add the new column current_quantity to the product_units table.
ALTER TABLE product_units
ADD current_quantity INT;

---Last quantity from vendor_inventory:
SELECT 
    product_id, 
    COALESCE(MAX(quantity), 0) AS last_quantity
FROM 
    vendor_inventory
GROUP BY 
    product_id;

---  Update current_quantity in product_units
UPDATE product_units
SET current_quantity = (
    SELECT 
        COALESCE(MAX(vi.quantity), 0)
    FROM 
        vendor_inventory vi
    WHERE 
        vi.product_id = product_units.product_id
)
WHERE EXISTS (
    SELECT 1
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
);
	



