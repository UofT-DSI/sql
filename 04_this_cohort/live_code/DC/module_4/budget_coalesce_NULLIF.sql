/* MODULE 4 */
/* NULLIF Budget (example from the slides) */

/* The following example creates a budgets table to show a department (dept) 
...its current budget (current_year) and its previous budget (previous_year). 

For the current year, NULL is used for departments with budgets that have not changed from the previous year, 
and 0 is used for budgets that have not yet been determined. 

To find out the average of only those departments that receive a budget and to include the budget value 
from the previous year (use the previous_year value, where the current_year is NULL), 
combine the NULLIF and COALESCE functions. */

DROP TABLE IF EXISTS temp.budgets; 
CREATE TEMP TABLE IF NOT EXISTS temp.budgets (
dept STRING
,current_year INT
,previous_year INT
);


INSERT INTO temp.budgets VALUES 
('software',1000,1000)
, ('candles',NULL,500)
, ('coffee', 400, 200)
, ('pencils',0, 50);


/*examine each of these columns */
SELECT 
NULLIF(current_year, previous_year)
--,NULLIF(COALESCE(current_year, previous_year), 0.00)
--,
--AVG(NULLIF(COALESCE(current_year, previous_year), 0.00)) 
FROM budgets


/* more NULLIF here: 
https://learn.microsoft.com/en-us/sql/t-sql/language-elements/nullif-transact-sql?view=sql-server-ver17
*/

