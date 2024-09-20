-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */




CREATE TEMP TABLE IF NOT EXISTS temp.revenue_per_product (revenue decimal);

WITH revenue_per_product AS (
	SELECT 
	v.vendor_name,
	p.product_name,
	cp.cost_to_customer_per_qty,
	cp.customer_id
	FROM 
		vendor v
	CROSS JOIN 
		product p
	CROSS JOIN 
		customer_purchases cp
	WHERE
		v.vendor_id = cp.vendor_id
		AND p.product_id = cp.product_id
)
	

SELECT 
	vendor_name,
	product_name,
	sum(cost_to_customer_per_qty*5) AS total
FROM revenue_per_product
GROUP by
	vendor_name,
	product_name;


	
	
-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */



/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

CREATE TABLE product_units AS
SELECT 
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM 
    product
WHERE 
    product_qty_type = 'unit';


INSERT INTO product_units (product_id,product_name,product_size,product_category_id,product_qty_type,
snapshot_timestamp)
VALUES(24,'Baguette','1/2 lb','3','unit',CURRENT_TIMESTAMP)



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/



-- it takes time to make a baguette; in SQL learning terms, it takes double the time!!! I will delete it nevertheless.


DELETE FROM product_units
WHERE product_id = 24


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
SET current_quantity = vi.quantity - cp.quantity
FROM vendor_inventory vi
JOIN customer_purchases cp ON vi.product_id = cp.product_id
WHERE product_units.product_id = vi.product_id;


SELECT *
FROM product_units
WHERE current_quantity IS NOT NULL;
