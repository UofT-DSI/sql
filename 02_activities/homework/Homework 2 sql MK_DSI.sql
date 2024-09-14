/* Write a query that returns everything in the customer table.*/
SELECT * FROM customer

/* Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.*/

SELECT *
FROM customer LIMIT 10

/*
    Write a query that returns all customer purchases of product IDs 4 and 9.*/
SELECT * FROM customer_purchases
WHERE product_id = 9 OR product_id = 4
	
 /*   Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
        two conditions using AND
        one condition using BETWEEN*/
		
SELECT *, (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases	
WHERE vendor_id >=8 AND vendor_id<=10

/*OR */

SELECT *, (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases	
WHERE vendor_id BETWEEN 8 and 10 
	

  /*  Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the product_id and product_name columns and add a column called prod_qty_type_condensed that displays the word “unit” if the product_qty_type is “unit,” and otherwise displays the word “bulk.”*/
SELECT product_id, product_name, 
CASE 
	WHEN product_qty_type = 'unit' 
	THEN 'unit'
	ELSE 'bulk' 
	END AS prod_qty_type_condensed
FROM product 
  
  /*  We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called pepper_flag that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.*/
SELECT product_id, product_name, 
CASE 
	WHEN product_qty_type = 'unit' 
	THEN 'unit'
	ELSE 'bulk' 
	END AS prod_qty_type_condensed,
CASE
	WHEN product_name like '%epper%'
	THEN 1
	ELSE 0
	END AS pepper_flag
FROM product;

/*OR*/  

SELECT product_id, product_name, 
CASE 
	WHEN product_qty_type = 'unit' 
	THEN 'unit'
	ELSE 'bulk' 
	END AS prod_qty_type_condensed,
CASE
	WHEN lower(product_name) like '%pepper%'
	THEN 1
	ELSE 0
	END AS pepper_flag
FROM product;

/*	Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the vendor_id field they both have in common, and sorts the result by vendor_name, then market_date.
*/
SELECT v.vendor_id, v.vendor_name, v.vendor_type, v.vendor_owner_first_name, v.vendor_owner_last_name, vb.booth_number, vb.market_date 
FROM vendor AS v
INNER JOIN vendor_booth_assignments as vb
ON v.vendor_id = vb.vendor_id
ORDER BY vendor_name, market_date

/*OR*/

SELECT v.*, vb.booth_number, vb.market_date
FROM vendor AS v
INNER JOIN vendor_booth_assignments as vb
ON v.vendor_id = vb.vendor_id
ORDER BY vendor_name, market_date