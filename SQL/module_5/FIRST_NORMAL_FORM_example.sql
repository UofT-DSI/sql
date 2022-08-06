drop table if exists temp.skills;
create temp table if not exists temp.skills
(
name TEXT,
OS TEXT,
software TEXT,
supervisor TEXT
);

insert into temp.skills
values("A","win","VSCode, MSSQL, RStudio", "Eric Yu"),
	("Thomas","mac", "Spyder, SQLite, RStudio", "Rohan Alexander");

drop table if exists temp.hold;
CREATE TABLE temp.hold AS
SELECT DISTINCT
name, 
OS,
SUBSTR(software, 1, INSTR(software, ',')-1) AS s1,
SUBSTR(software, INSTR(software, ',')+1, INSTR(SUBSTR(software, INSTR(software, ',')+1), ',')-1) AS s2,
SUBSTR(software, INSTR(SUBSTR(software, INSTR(software, ',')+1), ',')+ INSTR(software, ',')+1) AS s3,
supervisor

FROM skills;

SELECT name,OS,s1 AS software,supervisor FROM hold
UNION
SELECT name,OS,s2,supervisor FROM hold
UNION
SELECT name,OS,s3,supervisor FROM hold
