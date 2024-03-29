-- INSERT UPDATE DELETE

/*
DROP TABLE IF EXISTS temp.product_expanded;
CREATE TEMP TABLE product_expanded AS 
SELECT * FROM product
*/

/*
INSERT INTO product_expanded
VALUES(26,'Almonds','lbs',1,'lbs') 
*/

/*
UPDATE product_expanded
SET product_size = '1/2 lb'
--SELECT * from product_expanded  -- temporarily added so we could ensure the right one
WHERE product_id = 26
*/

DELETE FROM product_expanded
--SELECT * from product_expanded  -- temporarily added so we could ensure the right one
WHERE product_id = 26