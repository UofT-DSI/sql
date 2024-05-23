--dense_rank vs rank vs row_number

--dense_rank, rank, row_number

drop table if exists temp.row_rank_dense;

create temp table if not exists temp.row_rank_dense
(
emp_id INT,
salary int
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
,RANK() OVER(ORDER BY salary DESC) as [RANK]
,ROW_NUMBER() OVER(ORDER BY salary DESC) as [ROW_NUMBER]
,DENSE_RANK() OVER(ORDER BY salary DESC) as [DENSE_RANK]

 from temp.row_rank_dense