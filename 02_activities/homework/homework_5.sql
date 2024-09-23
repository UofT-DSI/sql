-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

WITH vendor_product AS (
	SELECT DISTINCT vendor_id , product_id, original_price
	FROM vendor_inventory
),
cross_table AS (	
SELECT vp.vendor_id, vp.product_id, c.customer_id, vp.original_price * 5 as sales 
FROM vendor_product vp
CROSS JOIN
customer c)

SELECT vendor_id, product_id, sum(sales) as total_sales
FROM cross_table
GROUP BY vendor_id, product_id;

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
CREATE TABLE product_units AS
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp FROM product
WHERE product_qty_type = 'unit'


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
INSERT INTO product_units
VALUES(1001,'macaroon','4cm',10,'unit',CURRENT_TIMESTAMP);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 
HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
DELETE FROM product_units WHERE product_name = 'macaroon';


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

WITH recent_quantity AS(
SELECT product_id, row_number() OVER(PARTITION by product_id ORDER BY market_date desc) as recent,
COALESCE(quantity,0) AS quantity
FROM vendor_inventory)

UPDATE product_units
SET current_quantity = (SELECT recent_quantity.quantity FROM recent_quantity
WHERE product_units.product_id = recent_quantity.product_id
AND recent_quantity.recent = 1);
