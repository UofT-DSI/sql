--Temp tables

DROP TABLE IF EXISTS new_vendor_inventory; -- delete it if it exists
CREATE TEMP TABLE IF NOT EXISTS new_vendor_inventory AS --create it if it doesnt

--table definition
SELECT * 
,original_price* 7 as inflation
FROM vendor_inventory;

DROP TABLE IF EXISTS new_new_vendor_inventory;
CREATE TEMP TABLE IF NOT EXISTS new_new_vendor_inventory AS

SELECT *
,inflation * 2 as super_inflation

FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory