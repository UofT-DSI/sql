
DROP TABLE IF EXISTS new_vendor_inventory;

CREATE TEMP TABLE IF NOT EXISTS new_vendor_inventory AS

SELECT * 
,original_price * 6 AS inflation

FROM vendor_inventory;

DROP TABLE IF EXISTS new_new_vendor_inventory;

CREATE TEMP TABLE IF NOT EXISTS new_new_vendor_inventory AS
SELECT * 
,inflation * 2 AS super_inflation

FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory