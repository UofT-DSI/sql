select * from penguins;

-- how many penguins were identified each year 
SELECT DISTINCT year
,COUNT(*) AS count
,SUM(COUNT(*)) OVER (ORDER BY year) AS running_total

 FROM penguins
GROUP BY year