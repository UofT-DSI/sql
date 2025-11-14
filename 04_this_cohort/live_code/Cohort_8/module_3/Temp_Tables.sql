/* MODULE 3 */
/* Temp Tables */


/* 1. Put our inflation query into a temp table, e.g. as temp.new_vendor_inventory*/

/* some structural code */
/* ...heads up, sometimes this query can be finnicky -- it's good to try highlighting different sections to help it succeed...*/

-- if a table named new_vendor_inventory exists, delete it, other do NOTHING
DROP TABLE IF EXISTS temp.new_vendor_inventory;

--make the table
CREATE TABLE temp.new_vendor_inventory AS

-- definition of the table
SELECT *
,original_price * 5 as inflation
FROM vendor_inventory;

SELECT * FROM new_vendor_inventory;



/* 2. put the previous table into another temp table, e.g. as temp.new_new_vendor_inventory  */

DROP TABLE IF EXISTS temp.new_new_vendor_inventory;

CREATE TABLE temp.new_new_vendor_inventory AS
SELECT *
,inflation*2 as super_inflation

FROM new_vendor_inventory;

SELECT * FROM new_new_vendor_inventory

