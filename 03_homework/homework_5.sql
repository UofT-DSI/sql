-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */


-- Estimating # rows before group by 
	-- No. of Products: 8  (select DISTINCT vendor_id, product_id from vendor_inventory )
	-- No. of customers:26   (Select count(distinct customer_id) from customer) 
	-- Expected Rows: 208 


with cross_sales as 
(
	select DISTINCT v.vendor_name, p.product_name  , c.customer_name, vi2.original_price, 
				vi2.original_price * 5 as revenue_for_5_qty 
		from vendor_inventory vi 
		LEFT JOIN vendor v on 
			v.vendor_id = vi.vendor_id 
		LEFT JOIN product p on 
			p.product_id = vi.product_id
		CROSS JOIN (select customer_first_name || customer_last_name as customer_name from customer) c  
		-- Performing a self-join to get the latest price from vendor inventory table 
		LEFT JOIN (select product_id, vendor_id, original_price, row_number() over(PARTITION by product_id order by market_date desc) as row_num from vendor_inventory) as vi2 
			where row_num = 1 and -- to keep the row for the latest market date only
				vi.vendor_id = vi2.vendor_id and 
				vi.product_id = vi2.product_id
) 
select vendor_name, product_name, sum(revenue_for_5_qty) as product_revenue 
from cross_sales 
group by 1, 2
 



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

drop table if exists product_units ;
create table  product_units as 
	select *, 
			CURRENT_TIMESTAMP as snapshot_timestamp 
	from product
	where product_qty_type = 'unit'
;
-- Validation Check 
select * from product_units; 

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

insert into product_units 
	VALUES( 10 , 
			'Eggs', 
			'1 dozen', 
			6,
			'unit',
			CURRENT_TIMESTAMP 
		);

-- Testing 
select * from product_units; 


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units 
	where product_name = 'Eggs' and ( snapshot_timestamp < ( select max(snapshot_timestamp) from product_units where product_name = 'Eggs') )
			--sub-query will identify all the old entries of this particular product to delete 
		
	
-- Testing 
select * from product_units where product_name = 'Eggs'; 


-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.
*/
ALTER TABLE product_units
ADD current_quantity INT;

-- Testing 
select * from product_units; 


/*
Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */


-- Creating a temp table that shows product id and latest quantity 
create temp table temp.last_qty_coalesce as 
	-- Generating row_number to identify sequence of market dates 
	with last_qty1 as (
			select product_id, quantity, market_date 
				, row_number() over(PARTITION by product_id order by market_date desc) as row_num  
				from vendor_inventory 
		),
		-- Another CTE to filter for the latest row 
			last_qty as (
			select product_id, quantity 
			from last_qty1 
			where row_num = 1 
		),
		-- CTE to add the missing product ids so that we have complete list of products ids that are included in product_units table 
			last_qty_coalesce as (
			select pu.product_id,  
				coalesce(lq.quantity, 0) as last_qty
				from product_units pu
				LEFT join last_qty lq on 
					lq.product_id = pu.product_id 
		) 

		-- validation check 
		select * from last_qty_coalesce
	;

-- Updating the table as per the instruction 
UPDATE product_units
SET current_quantity = last_qty_coalesce.last_qty
		from temp.last_qty_coalesce
  where last_qty_coalesce.product_id = product_units.product_id;	

	-- Validation Check 
  select * from product_units
	