--temp tables

DROP TABLE IF EXISTS new_vendor_invetory;
CREATE TEMP TABLE new_vendor_invetory AS
SELECT * 
,original_price * 6 as inflation

FROM vendor_inventory;

DROP TABLE IF EXISTS new_new_vendory_inventory;

CREATE TEMP TABLE new_new_vendory_inventory AS

SELECT * 
,inflation * 2 AS super_inflation
FROM new_vendor_invetory;

SELECT * FROM new_new_vendory_inventory