--string manipulation


SELECT DISTINCT

LTRIM('          THOMAS ROSENTHAL         ') as [ltrim]
,RTRIM('          THOMAS ROSENTHAL         ') as [rtrim]
,RTRIM(LTRIM('          THOMAS ROSENTHAL         ')) as [both]
--secondary use case
,LTRIM('A189A','A')
,REPLACE('A189A','A','')
,REPLACE('THOMAS ROSENTHAL',' ',' WILLIAM ')

--upper/lower
,LOWER(customer_first_name)
,UPPER(customer_last_name)
,customer_first_name || ' ' || customer_last_name as full_name --concat
,UPPER(customer_first_name) || ' ' || UPPER(customer_last_name) as UPPER_full_name --concat

--substring
,substr(customer_last_name,4) -- any length from the 4th character
,substr(customer_last_name,4,2)
,substr(customer_last_name, -5,4) -- counting from the right

,instr(customer_last_name,'r')
,length(customer_last_name)
,' THOMAS 

ROSENTHAL'
,replace(' THOMAS 

ROSENTHAL',char(10),'') -- removes the line breaks from this string
--,replace(customer_last_name,unicode(97))


from customer

WHERE customer_first_name REGEXP '(e)$' -- filtering to only ending in e -- has to be a valid regex
