SELECT CHAR(98) , UNICODE('b'),
product_name,
REPLACE(product_name,CHAR(45),'')

FROM product