-- INSERT UPDATE DELETE

--1) add a product to the TABLE
--2) change the product_size for that product
--3) delete our product

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
--SELECT * from product_expanded

--INSERT
INSERT INTO product_expanded
VALUES(26, 'Almonds', '1 lb', 1, 'lbs');

--UPDATE
--change the product_size for almonds from 1lb to 1/2kg
UPDATE product_expanded
SET product_size = '1/2 kg', product_qty_type = 'kg'
WHERE product_id = 26;

--DELETE 
--delete our almonds
DELETE FROM product_expanded -- finally, run with this
--SELECT * FROM product_expanded --first; remove when running w/ delete
WHERE product_id=26; -- second
--third, run the select + where statement

SELECT * FROM product_expanded