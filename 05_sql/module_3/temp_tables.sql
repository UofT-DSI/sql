-- temp tables

--if the table named "new_vendor_inventory" exists, delete it, otherwise do nothing (go to next line)
DROP TABLE IF EXISTS new_vendor_inventory;
--make a new table named "new_vendor_inventory" based on the following query results:
CREATE TEMP TABLE new_vendor_inventory AS

-- the definition of new_vendor_inventory
SELECT *, original_price * 5 AS inflation
FROM vendor_inventory;


DROP TABLE IF EXISTS new_new_vendor_inventory;
CREATE TEMP TABLE new_new_vendor_inventory AS
SELECT *,
inflation * 2 AS super_inflation
FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory


