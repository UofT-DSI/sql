/* MODULE 4 */
/* String Manipulations */


/* 1. ltrim, rtrim, trim*/
SELECT
LTRIM('              THOMAS ROSENTHAL            ') as [ltrim]
,RTRIM('              THOMAS ROSENTHAL            ') as [rtrim]
,TRIM('              THOMAS ROSENTHAL            ') as [trim]
,LTRIM(RTRIM('              THOMAS ROSENTHAL            ')) as [both]

/* 2. replace*/
,REPLACE('THOMAS ROSENTHAL',' ',' WILLIAM ') as full_name -- adding my middle name between the first and last name
,REPLACE('THOMAS ROSENTHAL','A','E') as a_to_e;

SELECT customer_first_name,
REPLACE(customer_first_name,'a','e') as cust_a_to_e,
REPLACE(customer_first_name,'a',customer_last_name) as chaos

FROM customer;

/* 3. upper, lower*/

SELECT customer_first_name,
UPPER(customer_first_name) as [upper],
LOWER(customer_first_name) as [lower]



/* 4. concat with || */
,customer_first_name || ' ' || customer_last_name as customer_name
,LOWER(customer_first_name)|| ' ' || UPPER(customer_last_name) || ' ' || customer_postal_code as cust_deets

FROM customer;

/* 5. substr */
SELECT DISTINCT
customer_last_name
,substr(customer_last_name,4) as [4] -- any length from the 4th character
,substr(customer_last_name,4,2) as [4,2] -- length of 2 from the 4th character
,substr(customer_last_name,-5,4) as [count_right] --counting from the RIGHT

FROM customer;


/* 6. length */

SELECT length(customer_last_name) as len
FROM customer

/* 7. unicode, char */


/* 8. REGEXP in a WHERE statement */



--------------------------------------------------------------------------------------------------------------------------------------------
