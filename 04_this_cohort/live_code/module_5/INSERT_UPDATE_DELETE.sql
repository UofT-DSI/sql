-- INSERT UPDATE DELETE

--1)add a product to the table
--2) change the product_size for that product
--3) delete our product 

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
--INSERT
INSERT INTO product_expanded
VALUES(26,'Almonds','1 lb',1,'lbs');

--UPDATE
-- change the product_size for almonds to 1/2 kg
UPDATE product_expanded
SET product_size = '1/2 kg', product_qty_type = 'kg'
WHERE product_id = 26;

--DELETE our almonds
DELETE FROM product_expanded
--SELECT * FROM product_expanded
WHERE product_id = 26