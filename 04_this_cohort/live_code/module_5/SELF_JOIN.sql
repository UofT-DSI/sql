/* MODULE 5 */
/* SELF JOIN */


/* 1. Create a self-joining hierarchy */

DROP TABLE IF EXISTS TEMP.employees;
CREATE TEMP TABLE TEMP.employees 
(
emp_id INT
,emp_name text
,mgr_id INT
);

INSERT INTO TEMP.employees
VALUES(1,'Thomas',3)
,(2,'Niyaz', 4)
,(3,'Rohan', NULL)
,(4, 'Jennie',3);

SELECT * FROM TEMP.employees;

SELECT e.emp_name, m.emp_name as mgr_name -- rename the column so its possible to understand the structure
,coalesce(m.emp_name,e.emp_name) as self_boss -- if you want Rohan to be his own boss

FROM temp.employees as e
LEFT JOIN temp.employees as m
	ON e.mgr_id = m.emp_id -- identifying which id is the parent and which id is the child




