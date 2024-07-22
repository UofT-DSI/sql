-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT DISTINCT vendor_name
,sum(original_price) AS total

FROM (
	SELECT DISTINCT vendor_owner_first_name || ' ' || vendor_owner_last_name AS vendor_name
	,product_name
	,customer_name
	,original_price


	FROM vendor_inventory vi
	INNER JOIN vendor v ON v.vendor_id = vi.vendor_id
	INNER JOIN product p ON p.product_id = vi.product_id

	CROSS JOIN 
		(SELECT DISTINCT customer_first_name || ' ' || customer_last_name AS customer_name FROM customer
		)
) x
GROUP BY vendor_name,product_name


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TABLE product_units AS

 SELECT p.*,
	 CURRENT_TIMESTAMP AS snapshot_timestamp
 FROM product AS p
 WHERE product_qty_type = "unit"

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units (product_id, product_name,
  product_size, product_category_id, product_qty_type, snapshot_timestamp)
      SELECT
          product_id,
          product_name,
          product_size,
          product_category_id,
          product_qty_type,
          CURRENT_TIMESTAMP
      FROM product AS p
      WHERE product_id = 7


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

WITH older_record AS
(SELECT product_id
		,MIN(snapshot_timestamp) AS snapshot_timestamp
		FROM product_units 
		WHERE product_id = 7)

DELETE FROM product_units
WHERE (product_id = 
	(SELECT  product_id 
	FROM older_record
		)
AND snapshot_timestamp = 	
	(SELECT  snapshot_timestamp 
	FROM older_record
		))

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

ALTER TABLE product_units
ADD current_quantity INT;

UPDATE product_units
SET current_quantity = (
	SELECT current_quantity 
	FROM (
		SELECT  p.product_id, COALESCE(quantity,0) as current_quantity

		FROM product_units p
		LEFT JOIN (
			SELECT *
			,ROW_NUMBER() OVER( PARTITION BY vi.product_id ORDER BY market_date DESC) AS rn
			FROM vendor_inventory vi 
		) vi ON p.product_id  = vi.product_id

		WHERE rn = 1 
		OR rn IS NULL
	) p
WHERE product_units.product_id = p.product_id);


