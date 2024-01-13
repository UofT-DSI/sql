--STRING MANIPULATIONS

/*
SELECT '                            THOMAS',
LTRIM('                            THOMAS'),
RTRIM('                            THOMAS                       '), -- only on the right
LTRIM(RTRIM('                            THOMAS                       ')),
REPLACE(REPLACE(REPLACE(REPLACE('A?lot-of,punctuation.','.',' '),',',' '),'-',' '),'?',' ')
*/

/*
SELECT product_name
,REPLACE(product_name,'Organic','')
,REPLACE(REPLACE(product_name,'Organic',''), ' - ','')
,LOWER(product_name)
,UPPER(product_name)

FROM product

--WHERE lower(product_name) LIKE '%pepper%'
*/


SELECT vendor_owner_first_name,
vendor_owner_first_name || ' '  || vendor_owner_last_name,
vendor_id || ': ' || vendor_owner_first_name || ' ' || vendor_owner_last_name,
substr(vendor_owner_first_name, 5, 6),
substr(vendor_owner_first_name,-4,3),

LENGTH(vendor_owner_first_name),

CHAR(65)
,UNICODE('A')

,UNICODE('ç')

,REPLACE('thomaç',CHAR(231),'s')

,REPLACE(' THOMAS
ROSENTHAL
IS
A
TEACHER', char(10),'')


FROM vendor

WHERE vendor_owner_first_name REGEXP '(s|a)$'