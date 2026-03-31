/* MODULE 2 */
/* SELECT */


/* 1. Select everything in the customer table */
SELECT * FROM customer;

/* 2. Use sql as a calculator */
SELECT 1+1 AS addition, 10*5 AS multiplication, pi()AS pi;

/* 3. Add order by and limit clauses */
SELECT *
FROM customer
ORDER BY customer_first_name
LIMIT 10;

/* 4. Select multiple specific columns */
SELECT customer_first_name, customer_last_name
FROM customer;

/* 5. Add a static value in a column */
SELECT 2026 AS this_year, 'March' AS this_month,customer_id
FROM customer

--------------------------------------------------------------------------------------------------------------------------------------------
