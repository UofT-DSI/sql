--SELF JOIN
DROP TABLE IF EXISTS temp.supervisors;
CREATE TEMP TABLE temp.supervisors
(
stu_id int,
stu_name text,
sup_id INT
);

INSERT INTO temp.supervisors
VALUES(1,'Thomas',3)
,(2,'Keli',3)
,(3,'Rohan',NULL)
,(4,'Niyaz',1);

SELECT * FROM temp.supervisors

--self JOIN
SELECT 
a.stu_name
,b.stu_name as super_name

FROM supervisors a
LEFT JOIN supervisors b
	ON a.sup_id = b.stu_id
