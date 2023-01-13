drop table if exists temp.table1;
create temp table if not exists temp.table1
(
FirstName TEXT,
Number INT
);

insert into temp.table1
values("A",1),
	("Thomas",2);

drop table if exists temp.table2;
create temp table if not exists temp.table2
(
LastName TEXT,
Number INT
);

insert into temp.table2
values("Mahfouz",1),
	("Rosenthal",2);
	
drop table if exists temp.table3;
create temp table if not exists temp.table3
(
FirstName TEXT,
LastName TEXT,
Symbol TEXT
);

insert into temp.table3
values("A","Smith","!"),
	("Edward","Rosenthal","?");

--SELECT * from table3

-- SELECT 
-- t1.FirstName
-- ,t1.Number
-- ,t3.Symbol
-- 
-- FROM table1 t1
-- LEFT JOIN table3 t3
-- 	ON t1.FirstName = t3.FirstName

-- SELECT 
-- t2.LastName
-- ,t2.Number
-- ,t3.Symbol
-- 
-- FROM table2 t2
-- LEFT JOIN table3 t3
-- 	ON t2.LastName = t3.LastName

SELECT
--t1.FirstName
t1.Number
--,t2.LastName
,t3.FirstName
,t3.LastName
,t3.Symbol

FROM table1 t1
LEFT JOIN table2 t2
	ON t1.Number = t2.Number
LEFT JOIN table3 t3
	ON t2.LastName = t3.LastName OR t1.FirstName  = t3. FirstName

