library(DBI)
library(RSQLite)
library(dplyr)

#set your location, slash direction will change for windows and mac
DB = '/Users/thomas/Documents/GitHub/DSI_SQL/SQL/FarmersMarket.db'

#establish your connection
conn <- dbConnect(SQLite(), DB) 

#run your query
db_df <- dbGetQuery(conn, 
    "WITH
    customer_markets_attended AS
    (
      SELECT DISTINCT
      customer_id,
      market_date
      FROM customer_purchases
      ORDER BY customer_id, market_date
    )
    SELECT
    cp.market_date,
    cp.customer_id,
    SUM(cp.quantity * cp.cost_to_customer_per_qty) AS purchase_total,
    COUNT(DISTINCT cp.vendor_id) AS vendors_patronized,
    COUNT(DISTINCT cp.product_id) AS different_products_purchased,
    CASE WHEN
    CAST(
      JULIANDAY((SELECT MIN(cma3.market_date)
                 FROM customer_markets_attended AS cma3
                 WHERE cma3.customer_id = cp.customer_id
                 AND cma3.market_date > cp.market_date
                 GROUP BY cma3.customer_id)) - 
        JULIANDAY(cp.market_date) AS INTEGER) <= 7
    THEN 1
    ELSE 0 END AS purchased_again_within_7_days
    FROM customer_purchases AS cp
    GROUP BY cp.customer_id, cp.market_date
    ORDER BY cp.customer_id, cp.market_date")

bi_df <- db_df %>% select(-market_date, -customer_id)

bi_df %>% count(purchased_again_within_7_days)

binomial <- glm(purchased_again_within_7_days ~ ., family = "binomial", data = bi_df)

summary(binomial)

broom::tidy(binomial)