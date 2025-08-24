-- SELF JOIN
DROP TABLE IF EXISTS temp.employees;
CREATE TEMP TABLE temp.employees 
(
emp_id INT
,emp_name text
,mgr_id INT
);

insert into temp.employees
Values(1,'Thomas',3)
,(2,'Niyaz', 4)
,(3,'Rohan', null)
,(4, 'Jennie',3);

SELECT * FROM temp.employees;

SELECT e.emp_name, m.emp_name as mgr_name
from temp.employees e
left join temp.employees m 
	 on e.mgr_id = m.emp_id