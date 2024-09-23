-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT an.vendor_name, an.product_name, 
       SUM(vi.original_price * 5) * (SELECT COUNT(DISTINCT customer_id) FROM customer_purchases) AS total_sales
FROM vendor_inventory vi
JOIN (
    -- Subquery for CROSS JOIN between vendor and product
    SELECT v.vendor_id, p.product_id, v.vendor_name, p.product_name
    FROM vendor AS v
    CROSS JOIN product AS p
) AS an
ON vi.vendor_id = an.vendor_id 
AND vi.product_id = an.product_id
GROUP BY vi.vendor_id, vi.product_id, an.vendor_name, an.product_name;




-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TABLE product_units (
product_id INTEGER,
product_name VARCHAR(50),
product_size VARCHAR(20),
product_category_id INTEGER,
product_qty_type VARCHAR(10),
snapshot_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO product_units (product_id , product_name,product_size , product_category_id,product_qty_type )
SELECT product_id , product_name,product_size , product_category_id,product_qty_type
FROM product
WHERE product_qty_type = 'unit';

select * FROM product_units


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
INSERT INTO product_units (product_id , product_name,product_size , product_category_id,product_qty_type )
VALUES ( 1000 , 'Apple Pie' , '8 oz' , 7 , 'unit' )
select * FROM product_units



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
DELETE FROM product_units
WHERE product_id = 1000;
select * FROM product_units


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

WITH FindLast AS (
    SELECT 
        product_id,market_date, 
        COALESCE(quantity, 0) AS LastQuantity,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS Rank
    FROM vendor_inventory
)

UPDATE product_units 
SET current_quantity = fl.LastQuantity
FROM FindLast fl
WHERE product_units.product_id = fl.product_id AND fl.Rank = 1;

SELECT * FROM product_units
