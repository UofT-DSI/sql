-- TEMP

-- if a table named "?" exists, delete it, otherwise do nothing
DROP TABLE IF EXISTS new_vendor_inventory;

--make
CREATE TEMP TABLE new_vendor_inventory AS

--definition of it
SELECT *,
original_price * 5 as inflation
FROM vendor_inventory;

--put a temp table into another one
DROP TABLE IF EXISTS new_new_vendor_inventory;

CREATE TEMP TABLE new_new_vendor_inventory AS 
SELECT *
,inflation*2 as super_inflation
from new_vendor_inventory;

SELECT * from new_new_vendor_inventory;

