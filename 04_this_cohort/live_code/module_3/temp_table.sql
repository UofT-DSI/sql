-- temp tables

-- if a table named new_vendor_inventory exists, delete it, other do NOTHING
DROP TABLE IF EXISTS temp.new_vendor_inventory;

--make the TABLE
CREATE TABLE temp.new_vendor_inventory AS

-- definition of the TABLE
SELECT * 
,original_price * 5 as inflation
FROM vendor_inventory;


-- put the table into another temp table

DROP TABLE IF EXISTS temp.new_new_vendor_inventory;


CREATE TABLE temp.new_new_vendor_inventory AS
SELECT * ,
inflation*2 as super_inflation
FROM temp.new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory