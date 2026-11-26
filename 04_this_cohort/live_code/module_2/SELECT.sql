/* MODULE 2 */
/* SELECT */


/* 1. Select everything in the customer table */
SELECT * FROM customer;

/* 2. Use sql as a calculator */
SELECT 1+1 as addition, 10*5 as multiplication, pi() as pi;


/* 3. Add order by and limit clauses */
SELECT * -- navy is a command
FROM customer --teal is a table
ORDER BY customer_first_name DESC -- purple is a column
LIMIT 10;


/* 4. Select multiple specific columns */
SELECT 
customer_last_name,
customer_first_name, -- comma between column names
customer_postal_code

FROM customer;


/* 5. Add a static value in a column */
SELECT 2026 as this_year, 'November' as this_month, customer_id
FROM customer

--------------------------------------------------------------------------------------------------------------------------------------------

