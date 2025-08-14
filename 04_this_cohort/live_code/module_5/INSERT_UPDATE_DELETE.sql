-- INSERT UPDATE DELETE

-- 1) add a product to the temp TABLE
-- 2) change the product_size for THAT product
-- 3) delete our product

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
--SELECT * FROM product_expanded

--INSERT
INSERT INTO product_expanded
VALUES(24, 'Almonds', '1 lbs', 1, 'lbs');

--UPDATE
--change the product_size for almonds to 1/2 kg
UPDATE product_expanded
SET product_size = '1/2 kg', product_qty_type = 'kg'
WHERE product_id = 24;

--DELETE 
DELETE FROM product_expanded
--SELECT * FROM product_expanded -- can help you determine you are looking at the right rows before delete
WHERE product_id = 24;


SELECT * FROM product_expanded