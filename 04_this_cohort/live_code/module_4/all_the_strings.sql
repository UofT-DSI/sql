-- string manipulation

SELECT DISTINCT 
--LTRIM('                         THOMAS ROSENTHAL            ') as [ltrim],
--RTRIM('                         THOMAS ROSENTHAL            ') as [rtrim],
--TRIM('                         THOMAS ROSENTHAL            ') as [both],
--LTRIM(RTRIM('                         THOMAS ROSENTHAL            ')) as [also_both]
product_name
,REPLACE(product_name,'a','e') -- replacing a's with e's
,REPLACE(product_name,'h','1') -- case sensitive
,REPLACE(product_name,' ','_') -- pot_hole_case

,UPPER(product_name) as upper_case
,LOWER(product_name) as lower_case
FROM product;

SELECT *
,customer_first_name || ' ' || customer_last_name as customer_name
,UPPER(customer_last_name) || ', ' || UPPER(customer_first_name) as upper_customer_name

,SUBSTR(customer_last_name,4) -- any length from the 4th character
,SUBSTR(customer_last_name, 4,2) -- 2 characters long from the 4th character
,SUBSTR(customer_last_name, -5,4) --starting from the right, 5 cahracter in and going 4 characters
,customer_last_name
,INSTR(customer_last_name,'a') -- always the first iteration, where is the first a

,LENGTH(customer_first_name || ' ' || customer_last_name)

FROM customer;


SELECT *,

'THOMAS


ROSENTHAL' -- added a linebreak

,replace('THOMAS

ROSENTHAL', char(10),' ')

,UNICODE('a')

FROM customer
WHERE customer_first_name REGEXP '(a)$'

