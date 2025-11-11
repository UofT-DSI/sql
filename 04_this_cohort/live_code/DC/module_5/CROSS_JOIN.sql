/* MODULE 5 */
/* CROSS  JOIN */


/* 1. CROSS JOIN sizes with product*/

DROP TABLE IF EXISTS TEMP.sizes;
CREATE TEMP TABLE IF NOT EXISTS TEMP.sizes (size TEXT);

INSERT INTO TEMP.sizes
VALUES('small'),
('medium'),
('large');

SELECT * FROM TEMP.sizes;

SELECT product_name, product_qty_type, size
FROM product -- 23 rows
CROSS JOIN temp.sizes -- 3 rows
-- 3*23 = 69 rows for the cartesian product
--WHERE product_qty_type = 'unit' -- maybe makes more sense, but reduces the number of rows



