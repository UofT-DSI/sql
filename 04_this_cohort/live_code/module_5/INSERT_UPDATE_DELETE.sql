--INSERT UPDATE AND DELETE

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS 
	SELECT * FROM product;
	
INSERT INTO product_expanded
VALUES(26, 'Almonds', '1 lb',1, 'lbs');

--update our new record product_size to 1/2 kg
UPDATE product_expanded
--SELECT * FROM product_expanded
SET product_size = '1/2 kg', product_qty_type = 'kg'
WHERE product_id = 26;

-- delete our almonds
DELETE FROM product_expanded
--SELECT * FROM product_expanded
WHERE product_id = 26;

SELECT * from product_expanded