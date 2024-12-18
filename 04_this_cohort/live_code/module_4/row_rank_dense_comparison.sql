--dense_rank vs rank vs row_number

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
,ROW_NUMBER() OVER(ORDER BY salary DESC) as [ROW_NUMBER]
,RANK() OVER(ORDER BY salary DESC) as [RANK]
,DENSE_RANK() OVER(ORDER BY salary DESC) as [DENSE_RANK]


FROM row_rank_dense