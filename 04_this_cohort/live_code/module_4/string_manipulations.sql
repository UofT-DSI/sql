--string manipulations

SELECT DISTINCT 
LTRIM('                 THOMAS ROSENTHAL              ') as [ltrim]
,RTRIM('                 THOMAS ROSENTHAL              ') as [rtrim]
,RTRIM(LTRIM('                 THOMAS ROSENTHAL              ')) as [both]
,TRIM('                 THOMAS ROSENTHAL              ')  as [also_both]

,product_name
,REPLACE(product_name, 'a','e')
,REPLACE(product_name,'h','1') -- case sensitivity
,REPLACE(product_name,' ','_') -- replace spaces with underscore (good way to get pot_hole_case)

,UPPER(product_name) as upper_case
,LOWER(product_name) as lower_case

,product_name || product_size

FROM product;

--concat
SELECT *
,customer_first_name || ' ' || customer_last_name as customer_name
,UPPER(customer_first_name) || ' ' || UPPER(customer_last_name) as upper_last_name

,SUBSTR(customer_last_name,4) -- any length from the 4th character
,SUBSTR(customer_last_name,4,2) --2 characters long from the 4th character
--,SUBSTR(customer_last_name, -5,4)
--,INSTR(customer_last_name,'a')

,length(customer_first_name || ' ' || customer_last_name)

,'THOMAS

ROSENTHAL' -- added a linebreak
,replace('THOMAS

ROSENTHAL', char(10), ' ') -- removing all linebreaks from this string

FROM customer

WHERE customer_first_name REGEXP '(a)$'

