-- CROSS JOIN

DROP TABLE IF EXISTS temp.sizes;
CREATE TEMP TABLE IF NOT EXISTS temp.sizes 
(size TEXT);

INSERT INTO temp.sizes
VALUES('small'),
('medium'),
('large');

SELECT * FROM temp.sizes;

SELECT product_name, size  -- 23*3 = 69 combinations
FROM product
CROSS JOIN temp.sizes