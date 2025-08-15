-- 2nf
drop table if exists temp.student;
drop table if exists temp.supervisor;
drop table if exists temp.student_software;

create temp table if not exists temp.supervisor
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT
);

INSERT INTO temp.supervisor(name)
select distinct supervisor
from skills;

create temp table if not exists temp.student
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
OS TEXT,
supervisor_id INTEGER,
CONSTRAINT "fk_supervisor_id" FOREIGN KEY ("supervisor_id") REFERENCES "supervisor" ("id")
)

INSERT INTO student(name, OS, supervisor_id)
SELECT DISTINCT 
h.name
,OS
,s.id AS supervisor_id

FROM hold h
JOIN supervisor s 
	on h.supervisor = s.name

CREATE TABLE temp.student_software AS
SELECT id, software

FROM student s
JOIN (
	SELECT name,OS,s1 as software, supervisor FROM hold
	UNION
	SELECT name,OS,s2 as software, supervisor FROM hold
	UNION
	SELECT name,OS,s3 as software, supervisor FROM hold
) u
ON s.name = u.name

--select * from student
--select * from supervisor
select * from student_software


