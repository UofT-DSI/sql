DROP TABLE IF EXISTS temp.budgets; 
CREATE TEMP TABLE IF NOT EXISTS temp.budgets (budget STRING, current_year INT, previous_year INT);

INSERT INTO temp.budgets VALUES ('software',1000,1000), ('candles',300,500);

SELECT --*, 

--NULLIF(current_year, previous_year)
--,COALESCE(NULLIF(current_year, previous_year),'0.00')
AVG(COALESCE(NULLIF(current_year, previous_year),'0.00'))

FROM budgets