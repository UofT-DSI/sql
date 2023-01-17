--CHAR/UNICODE

SELECT CHAR(98), UNICODE('b')

product_name,
REPLACE(product_name,CHAR(72),'')

FROM product

WHERE product_name REGEXP '(ic|ar)$' --REGEXP example!, products ending in 'ic' OR 'ar'
