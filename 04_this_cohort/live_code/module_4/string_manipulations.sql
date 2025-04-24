-- string manipulations

SELECT DISTINCT

LTRIM('                THOMAS ROSENTHAL                 ') as [ltrim]
,RTRIM('                THOMAS ROSENTHAL                 ') as [rtrim]
,TRIM('                THOMAS ROSENTHAL                 ') as [trimmed]
,LTRIM(RTRIM('                THOMAS ROSENTHAL                 ')) as [both]

--replace
,REPLACE('THOMAS ROSENTHAL', ' ', ' WILLIAM ' ) -- add my middle name between first name and last name
,REPLACE('THOMAS ROSENTHAL', 'a','') -- case sensitive
,REPLACE('THOMAS ROSENTHAL', 'A','') -- replaces both A's
,REPLACE(REPLACE(customer_first_name, 'a',''),'e','') as new_customer_first_name

,UPPER(customer_first_name) as [upper]
,LOWER(customer_first_name) as [lower]

--concat
,customer_first_name || ' ' || customer_last_name as customer_name
,UPPER(customer_first_name) || ' ' || UPPER(customer_last_name) || ' ' || customer_postal_code as upper_cust_name


FROM customer;

SELECT DISTINCT
customer_last_name
,SUBSTR(customer_last_name,4) -- any length from the 4th character
,substr(customer_last_name,4,2) 
,substr(customer_last_name, -5,4) -- counting from the right
,substr(customer_last_name,1,2) -- results with 2 characters
,substr(customer_last_name,0,2) -- results with 1 character instead of 2

--length
,length(customer_last_name)


,'THOMAS

ROSENTHAL'

,replace('THOMAS

ROSENTHAL', char(10), ' ' ) -- removing all instances of the line break from the string

FROM customer

WHERE customer_last_name REGEXP '(a)$' -- filtering to only end in a