/* MODULE 2 */
/* SELECT */


/* 1. Select everything in the customer table */
SELECT * FROM customer;


/* 2. Use sql as a calculator */
SELECT 1+1 as [2], pi() as [pi];


/* 3. Add order by and limit clauses */
SELECT * FROM customer
ORDER BY customer_last_name DESC -- z->a
LIMIT 5; -- only 5 rows



/* 4. Select multiple specific columns */
SELECT product_name, 
product_size,
product_qty_type

FROM product;


/* 5. Add a static value in a column */
SELECT '2025' as [this_year], -- persist the value 2025 across all rows that we returnm a static value
vendor_name,
vendor_type

FROM vendor;

