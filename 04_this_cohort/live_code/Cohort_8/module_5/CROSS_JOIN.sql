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


SELECT product_id, product_name, size
FROM temp.sizes
CROSS JOIN product



