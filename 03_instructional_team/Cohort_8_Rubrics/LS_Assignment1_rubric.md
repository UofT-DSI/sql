# Assignment 1: Meet the farmersmarket.db and Basic SQL

## General
  - Weight: *30 points*
  - Criteria: Participant Name on Assignment
  - Criteria: Assignment is free of noticeable typos
  - Criteria: One Logical Model exists
    - cannot be a duplicate of my example tables from Session 1 slides
  - Criteria: assignment1.sql is completed
  - Criteria: assignment1.sql is correct

## Section 1

### Prompt 1
- *(10 points total)*
- Two tables are diagramed as a logical model
  - Needs to contain table names, column names, relationships between columns, relationship-type
- Any format acceptable so long as a "logical model"

## Section 2
- *(10 points total)*
- *(6 points)* **All questions have been attempted** 
- *(4 points)* **The following questions return the correct result set:** 
  - WHERE, Question 2
  - JOIN Question 1

## Section 3
- *(10 points total)*
- *(6 points)* **All questions have been attempted** 
- *(4 points)* **The following questions return the correct result set:** 
  - AGGREGATE, Question 2
  - DATE, Question 2

## Criteria

|Criteria|Complete|Partial|Incomplete|
|--------|----|----|----|
|Section 1, Prompt 1 Requirements|All requirements are met.|Missing some requirements.|Several requirements are not met or diagram is not a logical model.|
|Section 2 Requirements|All requirements are met and result sets are correct.|Some questions missing or wrong result set.|Several questions missing.|
|Section 3 Requirements|All requirements are met and result sets are correct.|Some questions missing or wrong result set.|Several questions missing.|



## Section 2 answers
### SELECT
1. Write a query that returns everything in the customer table.
`SELECT * FROM customer`

2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.
```
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10
```

### WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9.

```
SELECT
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE customer_id IN (4, 9)
 ```

2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
1.  two conditions using AND
2.  one condition using BETWEEN

```
SELECT
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id >= 8
AND vendor_id <= 10
```

```
SELECT
market_date,
customer_id,
vendor_id,
product_id,
quantity,
quantity * cost_to_customer_per_qty AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10
ORDER BY market_date, vendor_id, product_id
 ```

### CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”

```
SELECT
product_id,
product_name,
CASE WHEN product_qty_type = "unit" THEN "unit"
ELSE "bulk" END AS prod_qty_type_condensed
FROM product
```

2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.

```
SELECT
product_id,
product_name,
CASE WHEN product_name LIKE '%epper%'
THEN 1 ELSE 0 END AS pepper_flag
FROM product
```

### JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_` assignments table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.

```
SELECT *
FROM vendor AS v
INNER JOIN vendor_booth_assignments AS vba
    ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date
```

## Section 3 answers
### # AGGREGATE
1. Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.

```
SELECT
vendor_id,
count(*) AS count_of_booth_assignments
FROM vendor_booth_assignments
GROUP BY vendor_id
```

2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name. 
**HINT**: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.

```
SELECT
cp.customer_id,
c.customer_first_name,
c.customer_last_name,
SUM(quantity * cost_to_customer_per_qty) AS total_spent

FROM customer c
LEFT JOIN customer_purchases cp
    ON c.customer_id = cp.customer_id

GROUP BY
cp.customer_id,
c.customer_first_name,
c.customer_last_name

HAVING total_spent > 2000

ORDER BY c.customer_last_name, c.customer_first_name
```

# Temp Table
1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal 
**HINT**: This is two total queries -- first create the table from the original, then insert the new 10th vendor. When inserting the new vendor, you need to appropriately align the columns to be inserted (there are five columns to be inserted, I've given you the details, but not the syntax)

```
CREATE TABLE temp.new_vendor AS
SELECT * FROM vendor

INSERT INTO temp.new_vendor
VALUES (10, "Thomass Superfood Store" , "Fresh Focused", "Thomas", "Rosenthal")
```

# Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
**HINT**: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are!

```
SELECT customer_id,
STRFTIME('%m',market_date) AS purchase_month,
STRFTIME('%Y', market_date) AS purchase_year

FROM customer_purchases
```


2. Using the previous query as a base, determine how much money each customer spent in April 2022. Remember that money spent is `quantity*cost_to_customer_per_qty`.

**HINTS**: you will need to AGGREGATE, GROUP BY, and filter...but remember, STRFTIME returns a STRING for your WHERE statement!!
```
SELECT customer_id,
STRFTIME('%m',market_date) AS purchase_month,
STRFTIME('%Y', market_date) AS purchase_year,
SUM(quantity*cost_to_customer_per_qty)

FROM customer_purchases

WHERE STRFTIME('%Y', market_date)  = '2023'
AND STRFTIME('%m',market_date) = '04'

GROUP BY STRFTIME('%Y', market_date) ,STRFTIME('%m', market_date), customer_id
```
