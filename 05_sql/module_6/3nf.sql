--3nf
drop table if exists temp.OS;
drop table if exists temp.software;
create temp table if not exists temp.OS
(
OS_id INTEGER,
OS TEXT,
win_only TEXT
);

insert into temp.OS
values(1,"win","TRUE"),
	(2,"mac","FALSE");


create temp table if not exists temp.software
(
software_id INTEGER PRIMARY KEY AUTOINCREMENT,
software TEXT,
win_only TEXT
);

INSERT INTO temp.software(software, win_only)
SELECT DISTINCT software, win_only
FROM student_software s
CROSS JOIN (
	SELECT * FROM OS WHERE OS = 'mac'
);

UPDATE software
SET win_only = 'TRUE'
WHERE software.software = ' MSSQL';

SELECT * FROM OS
--SELECT * FROM software


