/* MODULE 4 */
/* String Manipulations */


/* 1. ltrim, rtrim, trim*/
SELECT DISTINCT
LTRIM('                      THOMAS ROSENTHAL                  ') as [ltrim]
,RTRIM('                      THOMAS ROSENTHAL                  ') as [rtrim]
,TRIM('                      THOMAS ROSENTHAL                  ') as [trim]

/* 2. replace*/
,REPLACE('THOMAS ROSENTHAL','A','') as [not_my_name]
,customer_first_name
,REPLACE(customer_first_name,'a','') as new_customer_names
,REPLACE(REPLACE(customer_first_name,'a',''),'e','') as more_cust_names
,REPLACE(customer_first_name,'A','') as new_customer_names

/* 3. upper, lower*/

/* 4. concat with || */
,UPPER(customer_first_name) || ' ' || LOWER(customer_last_name) as FULL_name
,NULL || customer_first_name as [always_null] -- if you have nulls in a column with concat...you will have an issue

/* 5. substr */
,customer_first_name
,SUBSTR(customer_first_name,1,4) as first_four
,SUBSTR(customer_first_name,-5,4) as five_four

/* 6. length */
,LENGTH(customer_last_name) as last_name_length

/* 7. unicode, char */
,'

THOMAS 
ROSENTHAL

' as linebreak
,TRIM(REPLACE('

THOMAS 
ROSENTHAL

',char(10), ' ')) as better_line_break

FROM customer

/* 8. REGEXP in a WHERE statement */

WHERE customer_first_name REGEXP '(a)$' -- filtering to only end in A ... must be valid regex