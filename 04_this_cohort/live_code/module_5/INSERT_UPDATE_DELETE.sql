--INSERT UPDATE DELETE

DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS 
	SELECT * FROM product;
	
INSERT INTO product_expanded
VALUES(26, 'Almonds', '1 lb', 1, 'lbs');


--update the product_size for almonds to 1/2 lb
UPDATE product_expanded
SET product_size = '1/2 kg',product_qty_type = 'kg'
WHERE product_id = 26;

-- delete our almond
--DELETE from product_expanded
--SELECT * from product_expanded
--WHERE product_id = 26;

SELECT * from product_expanded