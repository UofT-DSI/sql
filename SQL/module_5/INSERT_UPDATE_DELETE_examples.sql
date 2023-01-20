--INSERT UPDATE DELETE

/*
CREATE TEMP TABLE new_vendor_inventory AS
SELECT * 
,original_price * 6 AS inflation

FROM vendor_inventory
*/

/*
--INSERT
INSERT INTO new_vendor_inventory
VALUES('2023-01-19',1000,1,8,18,18*6)
*/

/*
--UPDATE
UPDATE new_vendor_inventory
SET market_date = '2022-12-25'
WHERE market_date = '2020-10-10'
*/

--DELETE
DELETE FROM new_vendor_inventory
SELECT * FROM new_vendor_inventory
WHERE inflation = 18*6