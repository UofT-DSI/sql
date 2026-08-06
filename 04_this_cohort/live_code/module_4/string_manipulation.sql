/* MODULE 4 */
/* String Manipulations */


/* 1. ltrim, rtrim, trim*/
SELECT 
LTRIM('                         THOMAS ROSENTHAL                         ') as [ltrim]
,RTRIM('                         THOMAS ROSENTHAL                         ') as [rtrim]
,TRIM('                         THOMAS ROSENTHAL                         ') as [trim]
,LTRIM(RTRIM('                         THOMAS ROSENTHAL                         ')) as [both];

/* 2. replace*/
SELECT
customer_first_name
,REPLACE(customer_first_name,'a','e') as cust_a_to_e
,REPLACE(customer_first_name,'a',customer_last_name) as chaos

FROM customer;

/* 3. upper, lower*/

SELECT customer_first_name
,UPPER(customer_first_name) as [upper]
,LOWER(customer_first_name) as [lower]

FROM customer;


/* 4. concat with || */
SELECT *
,customer_first_name || ' ' || customer_last_name as customer_name
,LOWER(customer_first_name) || ' ' || UPPER(customer_last_name) || ' ' || customer_postal_code as customer_details
,NULL || 'thomas' as always_null

FROM customer;


/* 5. substr */

SELECT 
customer_last_name
,substr(customer_last_name,4) as [4] -- any length from the 4th character
,substr(customer_last_name,4,2) as [4,2] -- length of 2 from the 4th character
,substr(customer_last_name,-5,4) as count_right -- counting from the right 5 characters in 4 out
FROM customer;

/* 6. length */
SELECT 
customer_last_name, length(customer_last_name) as length

FROM customer;

/* 7. unicode, char */

SELECT UNICODE('b') as b;

SELECT 
'THOMAS

ROSENTHAL' as bad_spaced_name

,replace('THOMAS

ROSENTHAL',char(10),' ') as better_linebreak; -- removes all instances of line break from the string

/* 8. REGEXP in a WHERE statement */

SELECT * FROM customer
WHERE customer_last_name REGEXP '(a)$' -- filtering to customer last names ending in a

--------------------------------------------------------------------------------------------------------------------------------------------
