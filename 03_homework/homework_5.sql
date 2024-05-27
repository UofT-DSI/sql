-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT vendor_name, product_name,
round(sum(original_price *5), 2) as revenue_per_product
FROM
(SELECT
vendor_id,product_id
from vendor_inventory) as vendors_products
CROSS JOIN
(SELECT DISTINCT customer_id
from customer) as customers
JOIN
(SELECT product_id, original_price
from vendor_inventory) as prices
on vendors_product.product_id = prices.product_id
group by vendor_name, product_name

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

drop table if EXISTS temp.product_units;
create temp table product_units as
select *, current_timestamp as snapshot_timestamp
 from product
where product_qty_type = 'unit';


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units
values (24, 'Apple Pie', '15"', 3, 'unit', CURRENT_TIMESTAMP);
SELECT * from product_units;

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE from product_units
WHERE 
    product_name = 'Apple Pie'
    AND snapshot_timestamp = (
        SELECT MIN(snapshot_timestamp)
        FROM product_units
        WHERE product_name = 'Apple Pie')


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
    SELECT COALESCE(MAX(quantity), 0) 
    FROM vendor_inventory 
    WHERE vendor_inventory.product_id = product_units.product_id
)
WHERE EXISTS (
    SELECT 1 
    FROM vendor_inventory 
    WHERE vendor_inventory.product_id = product_units.product_id
);