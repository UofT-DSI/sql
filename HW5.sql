--Cross Join
--how many distinct vendors, product names are there (x)?
-- How many customers are there (y). Before your final group by you
-- should have the product of those two queries (x*y).

SELECT v.vendor_name,
	   p.product_name,
	   SUM(vi.original_price * 5) as product_sales_total
FROM 
	vendor_inventory vi
CROSS JOIN
	vendor v
CROSS JOIN
	product p
WHERE 
	vi.vendor_id = v.vendor_id 
AND vi.product_id = p.product_id
GROUP BY 
	v.vendor_name, 
	p.product_name

--INSERT
--1. Create a new table "product_units". This table will contain only
-- products where the product_qty_type = 'unit'. It should use all
-- of the columns from the product table, as well as a new column 
--for the CURRENT_TIMESTAMP. Name the timestamp column snapshot_timestamp.


DROP TABLE IF EXISTS product_units
	
CREATE TABLE product_units AS 
	SELECT *, CURRENT_TIMESTAMP as snapshot_timestamp
	FROM product 
	WHERE product_qty_type = 'unit'
		
--Using INSERT, add a new row to the table (with an updated
-- timestamp). This can be any product you desire (e.g. add another
-- record for Apple Pie).
	
INSERT INTO product_units
VALUES (15,'Carrot Cake','medium',9,'unit',CURRENT_TIMESTAMP)

--DELETE
--Delete the older record for the whatever product you added.

DELETE FROM product_units WHERE product_name = 'Carrot Cake'

--UPDATE
--1.We want to add the current_quantity to the product_units table.
-- First, add a new column, current_quantity to the table using the
-- following syntax.

ALTER TABLE product_units
ADD current_quantity INT

UPDATE product_units 
SET current_quantity = 
(SELECT COALESCE(vi.quantity,0)
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    ORDER BY vi.quantity DESC)
	

