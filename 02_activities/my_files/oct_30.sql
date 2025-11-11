SELECT *
FROM customer;

/* 2. Use sql as a calculator */
SELECT 1+1 as something, 10*5 as somethingelse, pi() as pi;


/* 3. Add order by and limit clauses */
SELECT * 
FROM customer
ORDER BY customer_first_name
LIMIT 10;


/* 4. Select multiple specific columns */
SELECT customer_id, customer_first_name 
FROM customer;

/* 5. Add a static value in a column */
SELECT 2025 as this_year, 'October' as this_month, 1+1, customer_id
FROM customer


/* MODULE 2 */
/* WHERE */

/* 1. Select only customer 1 from the customer table */
SELECT * 
FROM customer
WHERE customer_id = 1;


/* 2. Differentiate between AND and OR */
SELECT * 
FROM customer
WHERE customer_id = 1
OR customer_id = 2;


/* 3. IN */
SELECT * 
FROM customer
WHERE customer_id IN (3,4,5)
OR customer_postal_code IN ('M4M','M1L'); -- customers in these postal codes


/* 4. LIKE */
-- all the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

--- customer with a last name starting with a
SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

/* 5. Nulls and Blanks*/

SELECT * FROM product
WHERE product_size IS NULL -- null
OR product_size = ''; -- blank


/* 6. BETWEEN x AND y */
SELECT * 
FROM customer
WHERE customer_id BETWEEN 1 AND 20;
--dates

SELECT market_date, market_day, market_year
FROM market_date_info
WHERE market_date BETWEEN '2022-10-01' AND '2022-10-31' AND market_day = 'Wednesday'


/* MODULE 2 */
/* CASE */


SELECT * 
/* 1. Add a CASE statement declaring which days vendors should come */
,CASE WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
	WHEN vendor_type = 'Prepared Foods' THEN 'Thursday'
	ELSE 'Saturday'
END as day_of_specialty 

/* 2. Add another CASE statement for Pie Day */
CASE WHEN vendor_name = "Annie's Pies"
	THEN 'Annie is great'
	END as pie_day

/* 3. Add another CASE statement with an ELSE clause to handle rows evaluating to False */
CASE WHEN vendor_name LIE '%pie%'
	THEN 'Wednesday'
	ELSE 'Friday'
	END as also_pie_day

FROM vendor
	
/* 4. Experiment with selecting a different column instead of just a string value */
SELECT *
, CASE WHEN cost_to_customer_per_qty < '1.00'
	THEN cost_to_customer_per_qty*5
	ELSE cost_to_customer_per_qty
	END AS inflation

FROM customer_purchases



/* 6. BETWEEN x AND y */