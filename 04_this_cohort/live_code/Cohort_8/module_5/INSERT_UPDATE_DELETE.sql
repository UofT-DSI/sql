/* MODULE 5 */
/* INSERT UPDATE DELETE */


DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
--SELECT * FROM product_expanded

/* 1. add a product to the temp table */
--INSERT
INSERT INTO product_expanded
VALUES(24, 'Almonds', '1 lbs', 3, 'lbs');

SELECT * FROM product_expanded;

/* 2. change the product_size for THAT product */
--UPDATE
--change the product_size for almonds to 1/2 kg
UPDATE product_expanded
SET product_size = '1/2 kg', product_qty_type = 'kg'
--SELECT * FROM product_expanded
WHERE product_id = 24;

SELECT * FROM product_expanded;

/* 3. delete the newly added product */
--DELETE
DELETE FROM product_expanded
--SELECT * FROM product_expanded -- write this first, it can help you to determine you are looking at the right rows before deleting
WHERE product_id = 24;

SELECT * FROM product_expanded;


