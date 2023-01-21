library(palmerpenguins) #load some data
library(sqldf) #this allows us to run SQLite queries!
penguins <- penguins #create a dataframe
avg_mass <- sqldf('SELECT DISTINCT species, sex, AVG(body_mass_g) as avg_mass
      FROM penguins
      WHERE sex <> "NA"
      GROUP BY species, sex') #run a SQLite query with sqldf()

avg_mass