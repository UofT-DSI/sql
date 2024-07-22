--TEMP

-- if a table named "new_vendor_inventory" exists, delete it, other do nothing
DROP TABLE IF EXISTS new_vendor_inventory;

--make a new table called "new_vendor_inventory"
CREATE TEMP TABLE new_vendor_inventory AS

--definition of new_vendory_invetory
SELECT *, original_price * 5 as inflation
FROM vendor_inventory;

DROP TABLE IF EXISTS new_new_vendor_inventory;
CREATE TEMP TABLE new_new_vendor_inventory AS
SELECT *,
inflation *2 as super_inflation

FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory