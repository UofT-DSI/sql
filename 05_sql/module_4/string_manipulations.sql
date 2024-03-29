-- string manipulations

SELECT 
LTRIM('     THOMAS ROSENTHAL     ') as [ltrim], 
RTRIM('     THOMAS ROSENTHAL     ') as [rtrim] ,
LTRIM(RTRIM('     THOMAS ROSENTHAL     ')) as [both],
LTRIM('A189A','A') -- secondary usecase
--replace
,REPLACE('THOMAS ROSENTHAL', 'THOMAS','WILLIAM')
--upper/lower
,LOWER(customer_first_name)
,UPPER(customer_last_name)
,customer_first_name || ' ' || customer_last_name as full_name
,SUBSTR(customer_last_name, 4) -- any lenght from the 4th character
,SUBSTR(customer_last_name,4, 2)
,SUBSTR(customer_last_name,-4,4) -- counting from the  right

--length
,LENGTH(customer_last_name)

--
,UNICODE('a')
,REPLACE(customer_last_name,CHAR(97),'')

FROM customer

WHERE customer_first_name REGEXP '(e)$'