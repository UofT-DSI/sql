/* MODULE 5 */
/* INSERT UPDATE DELETE */


DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
--SELECT * FROM product_expanded

/* 1. add a product to the temp table */
--INSERT
INSERT INTO product_expanded
VALUES(24,'Almonds','1 lb',3,'lbs');


/* 2. change the product_size for THAT product */
--UPDATE
UPDATE product_expanded
SET product_size = '.5 kg', product_qty_type = 'kg'
WHERE product_id = 24;

/* 3. delete the newly added product */
--DELETE

DELETE FROM product_expanded
--SELECT * FROM product_expanded -- helping you determine which rows you are looking at, are they the right rows before you delete it?
WHERE product_id = 24;


--------------------------------------------------------------------------------------------------------------------------------------------
