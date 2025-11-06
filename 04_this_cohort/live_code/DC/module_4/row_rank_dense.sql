/* MODULE 4 */
/* Windowed functions: dense_rank, rank, row_number */


/* 1. Compare dense_rank, rank, and row_number */

DROP TABLE IF EXISTS TEMP.row_rank_dense;

CREATE TEMP TABLE IF NOT EXISTS TEMP.row_rank_dense
(
emp_id INT,
salary INT
);

INSERT INTO temp.row_rank_dense
VALUES
(1,200000),
(2,200000),
(3, 160000),
(4, 120000),
(5, 125000),
(6, 165000),
(7, 230000),
(8, 100000),
(9, 165000),
(10, 100000),
(11, 90000);

SELECT *
,ROW_NUMBER() OVER(ORDER BY salary DESC) as [row_number]
,RANK() OVER(ORDER BY salary DESC) as [rank]
,DENSE_RANK() OVER(ORDER BY salary DESC) as [dense_rank]


FROM row_rank_dense


