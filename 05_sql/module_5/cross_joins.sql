--CROSS JOIN

SELECT vendor_id,product_id
FROM vendor
CROSS JOIN product;

-- CROSS JOIN
CREATE TEMP TABLE abc
(col TEXT)
INSERT INTO temp.abc
VALUES('small')
INSERT INTO temp.abc
VALUES('medium')
INSERT INTO temp.abc
VALUES('large')


SELECT product_id, col as SIZE

FROM product
CROSS JOIN temp.abc