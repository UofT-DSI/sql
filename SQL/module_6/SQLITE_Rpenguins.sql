-- SAMPLE QUERY FROM PALMERPENGUINS
-- EXECUTED THIS ORIGINALLY IN R, RATHER THAN SQL
-- SEE Rpenguins.R FILE

SELECT DISTINCT 
species, 
sex, 
AVG(body_mass_g) as avg_mass

FROM penguins
WHERE sex != 'NA'
GROUP BY species, sex