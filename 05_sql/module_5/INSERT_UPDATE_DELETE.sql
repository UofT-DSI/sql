-- INSERT UPDATE DELETE

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS
	SELECT * FROM product;
	
INSERT INTO product_expanded
VALUES(26,'Almonds','1 lb',1,'lbs');

UPDATE product_expanded
SET product_size = '1/2 lb'
--SELECT * FROM product_expanded
WHERE product_id = 26;

DELETE FROM product_expanded
--SELECT * FROM product_expanded
WHERE product_id = 26;

select * from product_expanded