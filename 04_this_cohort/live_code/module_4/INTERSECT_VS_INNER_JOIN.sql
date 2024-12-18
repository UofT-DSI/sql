DROP TABLE IF EXISTS temp.temp1; 
CREATE TEMP TABLE IF NOT EXISTS temp.temp1
(id int);

INSERT INTO temp.temp1
VALUES(null)
,(1)
,(3)
,(3);

DROP TABLE IF EXISTS temp.temp2; 
CREATE TEMP TABLE IF NOT EXISTS temp.temp2
(id int);
INSERT INTO temp.temp2
VALUES(null)
,(2)
,(3)
,(3);

-- distinct and NULL
select * from temp1
INTERSECT
select * from temp2

select * from temp1
EXCEPT
select * from temp2

select * from temp2
EXCEPT
select * from temp1

-- not distinct and NOT NULL
select * from temp1 t
INNER JOIN temp2 x
	on t.id = x.id