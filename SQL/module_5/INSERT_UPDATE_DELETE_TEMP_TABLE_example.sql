drop table if exists temp.new_vendor_inventory;
CREATE  TEMP TABLE if not exists new_vendor_inventory AS
SELECT * 
,original_price * 6 AS inflation

FROM vendor_inventory;

SELECT * 
FROM new_vendor_inventory
