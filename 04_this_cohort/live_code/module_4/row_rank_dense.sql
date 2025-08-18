-- dense_rank, rank, row_number

DROP TABLE IF EXISTS temp.row_rank_dense;

CREATE TEMP TABLE IF NOT EXISTS temp.row_rank_dense
(
emp_id INT,
salary INT
);

INSERT INTO temp.row_rank_dense
VALUES(1,200000),
        (2,200000),
        (3, 160000),
	(4, 120000),
	(5, 125000),
	(6, 165000),
	(7, 230000),
	(8, 100000),
	(9, 165000),
	(10, 100000);
	
SELECT *
,row_number() OVER(ORDER BY salary desc) as [row_number]
,rank() OVER(ORDER BY salary desc) as [rank]
,dense_rank() OVER(ORDER BY salary desc) as [dense_rank]

FROM row_rank_dense
