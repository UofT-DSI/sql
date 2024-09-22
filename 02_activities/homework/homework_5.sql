-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT 
v.vendor_name, 
p.product_name, 
SUM(x.original_price*5) as [total_sales]
FROM vendor v
INNER JOIN  
		(SELECT  DISTINCT vendor_id, product_id, original_price
		FROM vendor_inventory)x 
		ON v.vendor_id = x.vendor_id
INNER JOIN product p on x.product_id = p.product_id
CROSS JOIN
	(SELECT customer_id
	FROM customer) cp
GROUP BY p.product_name
ORDER BY v.vendor_name

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

DROP TABLE IF EXISTS product_units;
CREATE TABLE product_units AS 
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit'

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units
VALUES (24, 'Strawberry Jam', '8.5 oz', 2, 'unit', CURRENT_TIMESTAMP)

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE from product_units
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

UPDATE product_units 
Set current_quantity = last_quantity

FROM (
		SELECT all_pi.product_id, IFNULL(lq.quantity, 0) AS last_quantity
		FROM (
				SELECT DISTINCT product_id
				FROM vendor_inventory
				UNION
				SELECT DISTINCT product_id
				FROM product_units
		) AS all_pi
		LEFT JOIN (
				SELECT product_id, quantity
				FROM (
						SELECT product_id, market_date, quantity
						,DENSE_RANK() OVER(PARTITION BY product_id ORDER BY market_date DESC) AS last_quantity
						FROM vendor_inventory
				)
				WHERE last_quantity = 1
		) AS lq
		ON all_pi.product_id = lq.product_id
) as cq
WHERE product_units.product_id = cq.product_id
