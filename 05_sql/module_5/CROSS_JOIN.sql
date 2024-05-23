-- CROSS JOIN

SELECT vendor_id,product_id
FROM vendor
CROSS JOIN product;

DROP TABLE IF EXISTS temp.abc;
CREATE TEMP TABLE IF NOT EXISTS temp.abc (col TEXT);
INSERT INTO temp.abc
VALUES('small');
INSERT INTO temp.abc
VALUES('medium');
INSERT INTO temp.abc
VALUES('large');

SELECT product_id, col as SIZE
FROM product
CROSS JOIN temp.abc