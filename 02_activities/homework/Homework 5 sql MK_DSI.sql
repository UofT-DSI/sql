--Homework 5: Expanding your Database
--  	Due on Friday, September 20 at 11:59pm
--  	Weight: 8% of total grade
--  	Upload one .sql file with your queries

--# CROSS JOIN
--1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their 
--products to sell to **every** customer on record. How much money would each vendor make per product? 
--Show this by vendor_name and product name, rather than using the IDs.
--**HINT**: Be sure you select only relevant columns and rows. 
--Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
--Think a bit about the row counts: how many distinct vendors, product names are there (x)? 
--How many customers are there (y). Before your final group by you should have the product of those two queries (x\*y). */

WITH VendorProduct AS (SELECT DISTINCT vi.vendor_id, product_id, original_price
    FROM vendor_inventory vi),
CustomerCount AS (SELECT COUNT(*) AS customer_count FROM customer)
SELECT 
    vp.vendor_id,
    vp.product_id,
    vp.original_price * 5 * cc.customer_count AS total_revenue
FROM 
    VendorProduct vp
CROSS JOIN CustomerCount cc; DROP TABLE IF EXISTS temp.sizes;
CREATE TEMP TABLE IF NOT EXISTS temp.sizes (size TEXT);

--# INSERT
--1. Create a new table "product_units". This table will contain only products where the 
--`product_qty_type = 'unit'`. It should use all of the columns from the product table,
-- as well as a new column for the `CURRENT_TIMESTAMP`.  Name the timestamp column `snapshot_timestamp`.
--2. Using `INSERT`, add a new row to the table (with an updated timestamp). 
--This can be any product you desire (e.g. add another record for Apple Pie). 

DROP TABLE IF EXISTS temp.product_units;
CREATE TEMP TABLE product_units AS
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES ('15','Pumpkin Pie', '10"', '3', 'unit', CURRENT_TIMESTAMP);
SELECT * FROM product_units;

--# DELETE 
--1. Delete the older record for the whatever product you added.
--**HINT**: If you don't specify a WHERE clause, [you are going to have a bad time](https://imgflip.com/i/8iq872).

DELETE FROM product_units
WHERE product_name = 'Pumpkin Pie'
AND snapshot_timestamp = 
(SELECT snapshot_timestamp
FROM product_units WHERE product_name = 'Pumpkin Pie'
ORDER BY snapshot_timestamp LIMIT 1);	
	
--Checking if the deletion worked
SELECT * FROM product_units

--# UPDATE
--1. We want to add the current_quantity to the product_units table. First, add a new column, `current_quantity` to the table using the following syntax.
--```
--ALTER TABLE product_units
--ADD current_quantity INT;
--```
--Then, using `UPDATE`, change the current_quantity equal to the **last** `quantity` value 
--from the vendor_inventory details. 
--**HINT**: This one is pretty hard. First, determine how to get the "last" quantity per product. 
--Second, coalesce null values to 0 (if you don't have null values, 
--figure out how to rearrange your query so you do.) 
--Third, `SET current_quantity = (...your select statement...)`, remembering that WHERE 
--can only accommodate one column. Finally, make sure you have a WHERE 
--statement to update the right row, you'll need to use `product_units.product_id` 
--to refer to the correct row within the product_units table. When you have all of 
--these components, you can run the update statement.

--executing alter table command:
ALTER TABLE product_units
ADD current_quantity INT;

--Checking if the altering  worked:
SELECT * FROM product_units

--Getting last quantities into the temp table
UPDATE product_units
SET current_quantity = COALESCE((SELECT vi.quantity
FROM vendor_inventory vi
WHERE vi.product_id = product_units.product_id
ORDER BY vi.market_date DESC LIMIT 1), 0)
WHERE product_id IN (SELECT DISTINCT product_id FROM vendor_inventory);

--Checking
SELECT * FROM product_units
