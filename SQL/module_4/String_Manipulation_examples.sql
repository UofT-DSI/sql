-- STRING manipulations


/*
SELECT 
--'                                      THOMAS',
--LTRIM ('                                       THOMAS         '),
--RTRIM('                           THOMAS              '),
--LTRIM(RTRIM('                           THOMAS              ')),
--RTRIM('THOMAS','S'),
REPLACE(product_name,'Organic',''),
LTRIM(REPLACE(REPLACE(product_name,'Organic',''), ' - ','')),
LTRIM(RTRIM(REPLACE(product_name,'Organic',''), ' - ')),
LOWER(product_name),
UPPER(product_name)

FROM product
*/


SELECT 
vendor_owner_first_name || ' ' || vendor_owner_last_name,
vendor_owner_first_name,
SUBSTR(vendor_owner_first_name, 5, 6),
SUBSTR(vendor_owner_first_name || ' ' || vendor_owner_last_name, 5,6),
SUBSTR(vendor_owner_first_name || ' ' || vendor_owner_last_name, -3,3),
LENGTH(vendor_owner_first_name || ' ' || vendor_owner_last_name),

SUBSTR(vendor_owner_first_name,0,3),
SUBSTR(vendor_owner_first_name,1,3),
SUBSTR(vendor_owner_first_name,-1,3),
SUBSTR(vendor_owner_first_name,-2,3)



FROM vendor

--WHERE vendor_owner_first_name || ' ' || vendor_owner_last_name = 'Chris Sylvan'

--GROUP BY vendor_owner_first_name || ' ' || vendor_owner_last_name
--HAVING MAX(LENGTH(vendor_owner_first_name || ' ' || vendor_owner_last_name)) = 15

/*
SELECT 
--INSTR('The instructor is named Thomas','Thomas') 
--,INSTR('The Instructor is named Thomas','Th')
--,INSTR('The Instructor is named Thomas','i'),
INSTR('FirstWord, SecondWord, ThirdWord',','),
SUBSTR('FirstWord, SecondWord, ThirdWord',0, INSTR('FirstWord, SecondWord, ThirdWord',',')) as FirstDelim

,SUBSTR('FirstWord, SecondWord, ThirdWord', 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1,
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) as SecondDelim
*/