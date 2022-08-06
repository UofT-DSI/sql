library(DBI)
library(RSQLite)
#set your location, slash direction will change for windows and mac
DB = '/Users/thomas/Documents/GitHub/DSI_SQL/SQL/FarmersMarket.db'
#establish your connection
conn <- dbConnect(SQLite(), DB) 
#run your query
db_df <- dbGetQuery(conn, "SELECT p.*,pc.product_category_name
                          FROM product p
                          JOIN product_category pc
                            ON p.product_category_id = pc.product_category_id")
#save
write.csv(db_df, file = "database-R.CSV")