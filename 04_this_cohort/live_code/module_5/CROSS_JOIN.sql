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

DROP TABLE IF EXISTS TEMP.colours;
CREATE TEMP TABLE IF NOT EXISTS TEMP.colours (colour TEXT);

INSERT INTO TEMP.colours
VALUES('red'),
('green'),
('orange'),
('purple');

SELECT * FROM TEMP.sizes;
SELECT * FROM TEMP.colours;

SELECT product_name,product_qty_type,size--,colour
FROM product -- 23 rows
CROSS JOIN temp.sizes -- 3 ROWS
-- 3*23 = 69 rows for the cartesian product
--CROSS JOIN temp.colours -- 4 ROWS -- add colour if you would like
-- 69*4 = 276 rows for the cartesian product




--------------------------------------------------------------------------------------------------------------------------------------------
