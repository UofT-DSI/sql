
-- SELECT '                 THOMAS',
-- LTRIM('             THOMAS') , 
-- RTRIM('        THOMAS       '),  -- only removes on the right
-- LTRIM(RTRIM('       THOMAS          '))


-- SELECT product_name,
-- REPLACE(product_name,'Organic',''),
-- REPLACE(REPLACE(product_name,'Organic',''),' - ',''),
-- LOWER(product_name),
-- UPPER(product_name)
-- 
-- FROM product
-- 
-- --WHERE product_name LIKE '%eppers%'

SELECT vendor_owner_first_name,
vendor_owner_first_name || ' ' || vendor_owner_last_name,
SUBSTR(vendor_owner_first_name, 5, 6),
SUBSTR(vendor_owner_first_name,-3,3)

FROM vendor