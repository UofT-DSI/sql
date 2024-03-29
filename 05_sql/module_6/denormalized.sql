-- normal forms creation

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
