
-- create a budget temp table
DROP TABLE IF EXISTS temp.budgets; 

-- here i am specifying the column types, this was asked, so budget is a string, current year is an integer, prev year also int
CREATE TEMP TABLE IF NOT EXISTS temp.budgets (budget STRING, current_year INT, previous_year INT); 
 

--nothing is yet in budget
INSERT INTO temp.budgets

-- so put as row 1
VALUES ('software',1000,1000)
--and row 2
, ('candles',300,500);

--show me the average difference in years
--NULLIF, if the numbers are the same, then NULL
--COALESCE, if the result is NULL then 0.00
--average across the values = change in years
SELECT  AVG(COALESCE(NULLIF(current_year, previous_year), 0.00)) 
FROM budgets

--result(300 [current year for candles] +0 / 2 [two rows] = 150.0)
