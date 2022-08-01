import pandas as pd
import pandasql as sql #this allows us to run SQLite queries!

p = "https://raw.githubusercontent.com/allisonhorst/palmerpenguins/master/inst/extdata/penguins.csv"
penguins = pd.read_csv(p)
yrly_penguins = sql.sqldf('''SELECT DISTINCT year, COUNT(*) AS count, 
                          SUM(COUNT(*)) OVER (ORDER BY year) AS running_total
                          FROM penguins
                          GROUP BY year''') #run a SQLite query with sqldf()
yrly_penguins
