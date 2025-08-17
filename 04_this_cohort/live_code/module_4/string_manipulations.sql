--string manipulations

SELECT  DISTINCT

LTRIM('                   THOMAS ROSENTHAL            ') 
,RTRIM('                   THOMAS ROSENTHAL            ')
,TRIM('                   THOMAS ROSENTHAL            ') 

,REPLACE('THOMAS ROSENTHAL', ' ', ' WILLIAM ') -- adds my middle name with spaces on both sides
,REPLACE('THOMAS ROSENTHAL','A','') 
,REPLACE('THOMAS ROSENTHAL','a','') 
--,REPLACE(customer_first_name,'a','')

,'THOMAS

ROSENTHAL'

,replace('THOMAS

ROSENTHAL', char(10), ' ') -- removing all instances of line breaks (char(10)) from this string

FROM customer;

-- upper / lower

SELECT DISTINCT
UPPER(customer_first_name)
,LOWER(customer_first_name)
,customer_first_name || ' ' || customer_last_name as customer_name
,UPPER(customer_first_name) || ' ' || UPPER(customer_last_name) as upper_full_name
, '' || 'thomas'

FROM customer

WHERE customer_first_name REGEXP '(a)$' -- filtering to only ending in a has to be valid regex