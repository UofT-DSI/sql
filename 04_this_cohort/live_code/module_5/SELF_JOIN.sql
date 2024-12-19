-- SELF JOIN
drop table if exists temp.employees;
create temp table temp.employees
(
emp_id int,
emp_name text,
mgr_id int
);

insert into temp.employees
Values(1,'Thomas',3)
,(2,'Ernani',4)
,(3,'Rohan',null)
,(4,'Jennie',3);


SELECT * FROM temp.employees

select a.emp_name,b.emp_name as mgr_name 
from temp.employees a
left join temp.employees b
	on a.mgr_id = b.emp_id
