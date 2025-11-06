/* MODULE 4 */
/* String Manipulations */


/* 1. ltrim, rtrim, trim*/
SELECT
LTRIM('                      THOMAS ROSENTHAL                  ') as [ltrim]
,RTRIM('                      THOMAS ROSENTHAL                  ') as [rtrim]
,TRIM('                      THOMAS ROSENTHAL                  ') as [trim]
,LTRIM(RTRIM('                      THOMAS ROSENTHAL                  ')) as [both]


/* 2. replace*/
,REPLACE('THOMAS ROSENTHAL',' ',' WILLIAM ') as full_name -- adding my middle name between first and last name
,REPLACE('THOMAS ROSENTHAL','A','E') as a_to_e
,REPLACE('THOMAS ROSENTHAL','A','') as no_a
,customer_first_name
,REPLACE(customer_first_name,'a','e') as cust_a_to_e
,REPLACE(customer_first_name,'a',customer_last_name) as chaos

/* 3. upper, lower*/
,UPPER(customer_first_name) as [upper]

/* 4. concat with || */
,customer_first_name || ' ' || customer_last_name as customer_name
,LOWER(customer_first_name) || ' ' || UPPER(customer_last_name) || ' ' || customer_postal_code as cust_deets


FROM customer;

/* 5. substr */
SELECT DISTINCT
customer_last_name
,SUBSTR(customer_last_name,4) as [4] -- any length from the 4th character
,SUBSTR(customer_last_name,4,2) as [4,2]
,SUBSTR(customer_last_name, -5,4) as [count_right] -- counting from the right

/* 6. length */
,LENGTH(customer_last_name) as len

/* 7. unicode, char */
,'THOMAS

ROSENTHAL' as bad_space_name

,replace('THOMAS


ROSENTHAL',char(10),' ') as better_linebreak -- removes all instances of the line break from the string


FROM customer

/* 8. REGEXP in a WHERE statement */

WHERE customer_last_name REGEXP '(a)$' -- filtering to cust last name ending in a
