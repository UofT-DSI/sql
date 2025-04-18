--TEMP tables

--if a table named "new_vendor_inventory" exists, delete it, otherwise do NOTHING
DROP TABLE IF EXISTS temp.new_vendor_inventory;

--make the TABLE
CREATE TABLE temp.new_vendor_inventory  AS

--definition of the table 
SELECT *,
original_price*5 as inflation
FROM vendor_inventory;

-- put a temp table into another one
DROP TABLE IF EXISTS new_new_vendory_inventory;

CREATE TABLE temp.new_new_vendor_inventory AS
select *
,inflation*2 as super_inflation
from temp.new_vendor_inventory;
