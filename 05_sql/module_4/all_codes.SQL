/**********************************************************************************
* This is a concatenation of all the selected files, including files in subfolders.
* The start and end of each file contains a comment with its name, as well as a
* print statement.
* Generated at: Wed May 22 2024 00:03:40 GMT-0400 (Eastern Daylight Time) 
***********************************************************************************
* These are the line numbers for the included files:
* 19		D:\MY REPOS\SQL\05_SQL\MODULE_4\COALESCE_NULLIF_AVG.SQL
* 43		D:\MY REPOS\SQL\05_SQL\MODULE_4\FULL_OUTER_JOIN.SQL
* 93		D:\MY REPOS\SQL\05_SQL\MODULE_4\IFNULL_COALESCE.SQL
* 130		D:\MY REPOS\SQL\05_SQL\MODULE_4\INTERSECT_EXCEPT.SQL
* 180		D:\MY REPOS\SQL\05_SQL\MODULE_4\NTILE.SQL
* 226		D:\MY REPOS\SQL\05_SQL\MODULE_4\RANK_ROWNUMBER_DENSERANK.SQL
* 269		D:\MY REPOS\SQL\05_SQL\MODULE_4\ROW_NUMBER.SQL
* 302		D:\MY REPOS\SQL\05_SQL\MODULE_4\STRING_MANIPULATIONS.SQL
* 353		D:\MY REPOS\SQL\05_SQL\MODULE_4\SUBSTR_INSTR.SQL
* 381		D:\MY REPOS\SQL\05_SQL\MODULE_4\UNION_UNIONALL.SQL
***********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\COALESCE_NULLIF_AVG.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\COALESCE_NULLIF_AVG.SQL'
GO
DROP TABLE IF EXISTS temp.budgets; 
CREATE TEMP TABLE IF NOT EXISTS temp.budgets (budget STRING, current_year INT, previous_year INT);

INSERT INTO temp.budgets VALUES ('software',1000,1000), ('candles',300,500);

SELECT --*, 

--NULLIF(current_year, previous_year)
--,COALESCE(NULLIF(current_year, previous_year),'0.00')
AVG(COALESCE(NULLIF(current_year, previous_year),'0.00'))

FROM budgets
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\COALESCE_NULLIF_AVG.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\COALESCE_NULLIF_AVG.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\FULL_OUTER_JOIN.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\FULL_OUTER_JOIN.SQL'
GO
--FULL OUTER JOIN WITH A UNION

DROP TABLE IF EXISTS temp.store1; 
CREATE TEMP TABLE IF NOT EXISTS temp.store1
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store1
VALUES("tiger",6),
        ("elephant",2),
        ("princess", 4);


DROP TABLE IF EXISTS temp.store2;
CREATE TEMP TABLE IF NOT EXISTS temp.store2
(
costume TEXT,
quantity INT
);

INSERT INTO temp.store2
VALUES("tiger",2),
	("dancer",7),
	("superhero", 5);
	
SELECT s1.costume, s1.quantity as store1_quantity, s2.quantity as store2_quantity

FROM store1 s1
LEFT JOIN store2 s2 on s1.costume = s2.costume

UNION ALL

SELECT s2.costume, s1.quantity, s2.quantity
FROM store2 s2
LEFT JOIN store1 s1 on s2.costume = s1.costume
WHERE s1.quantity is NULL
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\FULL_OUTER_JOIN.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\FULL_OUTER_JOIN.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\IFNULL_COALESCE.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\IFNULL_COALESCE.SQL'
GO
--IFNULL and coalesce + NULLIF

SELECT *,
IFNULL(product_size,'Unknown')

--less meaningful
,IFNULL(product_size,product_category_id) as product_size
,IFNULL(product_size,product_qty_type) -- NULL NULL
,coalesce(product_size,product_qty_type,'missing')

FROM product;


SELECT *,
IFNULL(product_size,'Unknown') as product_size

--nullif
,NULLIF(product_size,'') -- findinv values in the product_size column that "blank" strings and setting them to null if they are blank


from product

WHERE 1=1
--AND product_size is null -- filter only null values (no blanks
AND NULLIF(product_size,'') IS NULL -- filtering rows BOTH null and blank
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\IFNULL_COALESCE.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\IFNULL_COALESCE.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\INTERSECT_EXCEPT.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\INTERSECT_EXCEPT.SQL'
GO
--INTERSECT / EXCEPT

--products that have been sold (e.g. are in customer purchases and product)
SELECT product_id
FROM product
INTERSECT
SELECT product_id
FROM customer_purchases;

--products that have NOT been sold (e.g. are NOT in customer purchases even though in product)
--plus their names!
SELECT x.product_id,product_name FROM (
	SELECT product_id
	FROM product
	EXCEPT
	SELECT product_id
	FROM customer_purchases ) x
JOIN product p on x.product_id = p.product_id;


--products that do not exist, because no product purchased is NOT in the product table

--NOTHING!!
SELECT product_id
FROM customer_purchases
EXCEPT
SELECT product_id
FROM  product

--can put it in a where clause instead
SELECT * FROM 
product
WHERE product_id IN (
	SELECT product_id
	FROM product
	EXCEPT
	SELECT product_id
	FROM customer_purchases)
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\INTERSECT_EXCEPT.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\INTERSECT_EXCEPT.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\NTILE.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\NTILE.SQL'
GO

--ntile (4,5,100)

-- bucket daily sales


SELECT *
,NTILE(4) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as quartile
,NTILE(5) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as quintile
,NTILE(100) OVER(PARTITION BY vendor_name ORDER BY sales ASC) as percentile
		
FROM (

	SELECT
	md.market_date
	,market_day
	,market_week
	,market_year
	,vendor_name
	,SUM(quantity*cost_to_customer_per_qty) AS sales
	
	
	FROM customer_purchases cp -- gets sales details
	JOIN market_date_info as md -- gets all the date columns
		ON cp.market_date = md.market_date
	JOIN vendor v -- gets the vendor name
		ON v.vendor_id = cp.vendor_id
	
	GROUP BY md.market_date, v.vendor_id


	) x
	

GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\NTILE.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\NTILE.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\RANK_ROWNUMBER_DENSERANK.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\RANK_ROWNUMBER_DENSERANK.SQL'
GO
--dense_rank vs rank vs row_number

--dense_rank, rank, row_number

drop table if exists temp.row_rank_dense;

create temp table if not exists temp.row_rank_dense
(
emp_id INT,
salary int
);


INSERT INTO temp.row_rank_dense
VALUES(1,200000),
        (2,200000),
        (3, 160000),
		(4, 120000),
		(5, 125000),
		(6, 165000),
		(7, 230000),
		(8, 100000),
		(9, 165000),
		(10, 100000);

SELECT *
,RANK() OVER(ORDER BY salary DESC) as [RANK]
,ROW_NUMBER() OVER(ORDER BY salary DESC) as [ROW_NUMBER]
,DENSE_RANK() OVER(ORDER BY salary DESC) as [DENSE_RANK]

 from temp.row_rank_dense
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\RANK_ROWNUMBER_DENSERANK.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\RANK_ROWNUMBER_DENSERANK.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\ROW_NUMBER.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\ROW_NUMBER.SQL'
GO
--windowed functions


--what product is the highest price per vendor
SELECT *

FROM  (
		SELECT 
		vendor_id
		,market_date
		,product_id
		,original_price
		,ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) as price_rank
		
		FROM vendor_inventory

		) x

WHERE x.price_rank = 1;

		
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\ROW_NUMBER.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\ROW_NUMBER.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\STRING_MANIPULATIONS.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\STRING_MANIPULATIONS.SQL'
GO
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

GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\STRING_MANIPULATIONS.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\STRING_MANIPULATIONS.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\SUBSTR_INSTR.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\SUBSTR_INSTR.SQL'
GO
--substring & instring together

SELECT 
'FirstWord, SecondWord, ThirdWord',
 SUBSTR('FirstWord, SecondWord, ThirdWord',0, INSTR('FirstWord, SecondWord, ThirdWord',',')) as FirstDelim
 --,SUBSTR('FirstWord, SecondWord, ThirdWord',0, 10) as FirstDelim -- same thing but not dynamic
 ,SUBSTR('FirstWord, SecondWord, ThirdWord', 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1,
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) as SecondDelim
  
  ,SUBSTR('FirstWord, SecondWord, ThirdWord',
  INSTR(
    (SUBSTR('FirstWord, SecondWord, ThirdWord',
    INSTR('FirstWord, SecondWord, ThirdWord',',')+1))
  ,',') + 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) AS ThirdDelim
GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\SUBSTR_INSTR.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\SUBSTR_INSTR.SQL'
GO
/*********************************************************************************/
/*********************************************************************************
* Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\UNION_UNIONALL.SQL
**********************************************************************************/
print 'Start: D:\MY REPOS\SQL\05_SQL\MODULE_4\UNION_UNIONALL.SQL'
GO
--UNION/UNIONALL

--most and least expensive product by vendor with a UNION


SELECT vendor_id, product_id, original_price, rn_min as [row_number] FROM 
	(
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price ASC) as rn_min
	
	FROM vendor_inventory
	) x
	
where rn_min = 1
	
UNION -- union returned 5 rows, union all 6 rows (vendor 4 duplicate)

SELECT * FROM 
	(
	SELECT DISTINCT vendor_id, product_id, original_price,
	ROW_NUMBER() OVER(PARTITION BY vendor_id ORDER BY original_price DESC) as rn_max
	
	FROM vendor_inventory
	) x
	
where rn_max = 1

GO
/*********************************************************************************
* End: D:\MY REPOS\SQL\05_SQL\MODULE_4\UNION_UNIONALL.SQL
**********************************************************************************/
print 'End: D:\MY REPOS\SQL\05_SQL\MODULE_4\UNION_UNIONALL.SQL'
GO
/*********************************************************************************/