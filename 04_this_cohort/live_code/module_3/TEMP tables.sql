--temp tables

-- if a table named "new_vendor_inventory exist, delete it, otherwise do NOTHING
DROP TABLE IF EXISTS new_vendor_inventory;

--make the TABLE
CREATE TEMP TABLE new_vendor_inventory AS
--definition of the TABLE
SELECT *
, original_price * 5 as inflation
FROM vendor_inventory;

SELECT * FROM new_vendor_inventory;

-- put a temp table into another one
DROP TABLE IF EXISTS new_new_vendor_inventory;

CREATE TEMP TABLE  new_new_vendor_inventory AS
SELECT *
,inflation*2 as super_inflation
FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory