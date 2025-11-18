# Assignment 2: Design a Logical Model and Advanced SQL

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

#### Submission Parameters:
* Submission Due Date: `November 12, 2025`
* Weight: 70% of total grade
* The branch name for your repo should be: `assignment-two`
* What to submit for this assignment:
    * This markdown (Assignment2.md) with written responses in Section 1 and 4
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
    * One .sql file 
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pulls/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `assignment-two`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.

***

## Section 1:
You can start this section following *session 1*, but you may want to wait until you feel comfortable wtih basic SQL query writing. 

Steps to complete this part of the assignment:
- Design a logical data model
- Duplicate the logical data model and add another table to it following the instructions
- Write, within this markdown file, an answer to Prompt 3


###  Design a Logical Model

#### Prompt 1
Design a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. 

Additionally, include a date table. 

There are several tools online you can use, I'd recommend [Draw.io](https://www.drawio.com/) or [LucidChart](https://www.lucidchart.com/pages/).

**HINT:** You do not need to create any data for this prompt. This is a conceptual model only. 

![](/Users/tanveerrouf/Documents/Soc Phd/SOC Fall 2025/Data Science Certificate/sql/02_activities/assignments/DC_Cohort/images/SQL_Ass2_Prompt1.png)


#### Prompt 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![](/Users/tanveerrouf/Documents/Soc Phd/SOC Fall 2025/Data Science Certificate/sql/02_activities/assignments/DC_Cohort/images/SQL_Ass2_Prompt2.png)


#### Prompt 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2? 

**HINT:** search type 1 vs type 2 slowly changing dimensions. 

```
SCD Type 1 (Overwrite) – When an address changes we simply UPDATE the existing row; only the latest address is kept, all history is lost.
SCD Type 2 (Historical) – Each change triggers an INSERT of a new row (surrogate key + effective dates), preserving every past address for audit or analysis.
```

***

## Section 2:
You can start this section following *session 4*.

Steps to complete this part of the assignment:
- Open the assignment2.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment2.sql)
	- or, from your local forked repository  
- Complete each question


### Write SQL

#### COALESCE
1. Our favourite manager wants a detailed long list of products, but is afraid of tables! We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:
```
SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product
```

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first column with nulls, and 'unit' for the second column with nulls. 

**HINT**: keep the syntax the same, but edited the correct components with the string. The `||` values concatenate the columns into strings. Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. All the other rows will remain the same.

<div align="center">-</div>

SELECT
  product_name | ', ' | COALESCE(product_size, '') | ' (' | COALESCE(product_qty_type, 'unit') | ')'
FROM
  product;


#### Windowed Functions
1. Write a query that selects from the customer_purchases table and numbers each customer’s visits to the farmer’s market (labeling each market date with a different number). Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on each new market date for each customer, or select only the unique market dates per customer (without purchase details) and number those visits. 

**HINT**: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK().

SELECT
    customer_id,
    market_date,
    -- DENSE_RANK() assigns the same rank to ties (i.e., multiple purchases on the same date)
    DENSE_RANK() OVER (
        -- Restart the numbering for each unique customer
        PARTITION BY customer_id
        -- Order by the date to ensure the ranking is chronological
        ORDER BY market_date ASC
    ) AS visit_number
FROM
    customer_purchases
ORDER BY
    customer_id, market_date;


2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, then write another query that uses this one as a subquery (or temp table) and filters the results to only the customer’s most recent visit.

Part 1: Reverse Numbering (Most Recent Visit is Rank 1)
This query ranks all of a customer's purchases based on market_date, with the most recent date receiving a rank of 1.
SELECT
  customer_id,
  market_date,
  DENSE_RANK() OVER (
    PARTITION BY customer_id
    ORDER BY market_date DESC
  ) AS visit_number_desc
FROM
  customer_purchases
ORDER BY
  customer_id,
  market_date DESC;

Part 2: Filter to Only the Most Recent Visit (Using a Subquery)
This query uses the logic from Part 1 within a subquery (or derived table, aliased as ranked_visits) and filters the results to only include those rows where the rank is 1.
SELECT
  ranked_visits.customer_id,
  ranked_visits.market_date
FROM (
  SELECT
    customer_id,
    market_date,
    DENSE_RANK() OVER (
      PARTITION BY customer_id
      ORDER BY market_date DESC
    ) AS visit_number_desc
  FROM
    customer_purchases
) AS ranked_visits
WHERE
  ranked_visits.visit_number_desc = 1
ORDER BY
  ranked_visits.customer_id,
  ranked_visits.market_date DESC;





3. Using a COUNT() window function, include a value along with each row of the customer_purchases table that indicates how many different times that customer has purchased that product_id.

<div align="center">-</div>

SELECT
    customer_id,
    product_id,
    market_date,
    COUNT(product_id) OVER (
        -- Partition by customer AND product to count purchases of this specific product by this specific customer
        PARTITION BY customer_id, product_id
    ) AS times_purchased_this_product
FROM
    customer_purchases
ORDER BY
    customer_id,
    product_id,
    market_date;


#### String manipulations
1. Some product names in the product table have descriptions like "Jar" or "Organic". These are separated from the product name with a hyphen. Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

**HINT**: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. 

SELECT
    product_name,
    -- Use INSTR to find the position of the hyphen. If found (>0), extract the substring starting
    -- immediately after the hyphen (+ 1) all the way to the end of the string.
    -- TRIM() removes leading/trailing spaces from the extracted description.
    CASE
        WHEN INSTR(product_name, '-') > 0
        THEN TRIM(
                SUBSTR(
                    product_name,
                    INSTR(product_name, '-') + 1
                )
             )
        ELSE NULL -- Return NULL if no hyphen is present
    END AS product_description
FROM
    product;


2. Filter the query to show any product_size value that contain a number with REGEXP. 

<div align="center">-</div>

SELECT product_name,
    CASE
        WHEN INSTR(product_name, '-') > 0
        THEN TRIM(
            SUBSTR(
                product_name,
                INSTR(product_name, '-') + 1
            )
        )
        ELSE NULL -- Return NULL if no hyphen is present
    END AS product_description
FROM product
/* Filter the query to show any product_size value that contain a number with REGEXP. */
WHERE product_size REGEXP '[0-9]';


#### UNION
1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

**HINT**: There are a possibly a few ways to do this query, but if you're struggling, try the following: 1) Create a CTE/Temp Table to find sales values grouped dates; 2) Create another CTE/Temp table with a rank windowed function on the previous query to create "best day" and "worst day"; 3) Query the second temp table twice, once for the best day, once for the worst day, with a UNION binding them. 

***

WITH daily_sales AS (
    SELECT
        market_date,
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM
        customer_purchases
    GROUP BY
        market_date
),
ranked_sales AS (
    SELECT
        market_date,
        total_sales,
        DENSE_RANK() OVER (ORDER BY total_sales DESC) AS best_rank,
        DENSE_RANK() OVER (ORDER BY total_sales ASC) AS worst_rank
    FROM
        daily_sales
)
SELECT
    market_date,
    total_sales,
    'Best day' AS day_type
FROM
    ranked_sales
WHERE
    best_rank = 1

UNION

SELECT
    market_date,
    total_sales,
    'Worst day' AS day_type
FROM
    ranked_sales
WHERE
    worst_rank = 1;


## Section 3:
You can start this section following *session 5*.

Steps to complete this part of the assignment:
- Open the assignment2.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment2.sql)
	- or, from your local forked repository  
- Complete each question

### Write SQL

#### Cross Join
1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** customer on record. How much money would each vendor make per product? Show this by vendor_name and product name, rather than using the IDs.

**HINT**: Be sure you select only relevant columns and rows. Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. Think a bit about the row counts: how many distinct vendors, product names are there (x)? How many customers are there (y). Before your final group by you should have the product of those two queries (x\*y). 

<div align="center">-</div>

WITH vendor_products AS (
    -- Distinct vendor–product pairs with their price
    SELECT DISTINCT
        v.vendor_name,
        p.product_name,
        vi.original_price
    FROM vendor_inventory vi
    JOIN vendor  v ON vi.vendor_id  = v.vendor_id
    JOIN product p ON vi.product_id = p.product_id
),
vp_customer_sales AS (
    -- Cross join each vendor–product with every customer
    -- Each customer buys 5 units of that product
    SELECT
        vp.vendor_name,
        vp.product_name,
        5 * vp.original_price AS sale_amount
    FROM vendor_products vp
    CROSS JOIN customer c
)
SELECT
    vendor_name,
    product_name,
    SUM(sale_amount) AS total_revenue
FROM vp_customer_sales
GROUP BY
    vendor_name,
    product_name
ORDER BY
    vendor_name,
    product_name;


#### INSERT
1. Create a new table "product_units". This table will contain only products where the `product_qty_type = 'unit'`. It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  Name the timestamp column `snapshot_timestamp`.

2. Using `INSERT`, add a new row to the product_unit table (with an updated timestamp). This can be any product you desire (e.g. add another record for Apple Pie). 

<div align="center">-</div>

/* \ STEP 1: CREATE and POPULATE the initial product_units table */
-- 1.1 Drop the table if it exists to avoid errors
DROP TABLE IF EXISTS product_units;
-- 1.2 Create the table with explicit column types (including TEXT for DATETIME in SQLite)
CREATE TABLE product_units ( product_id INTEGER, product_name TEXT, product_size TEXT, product_category_id INTEGER, product_qty_type TEXT, snapshot_timestamp TEXT -- Using TEXT for SQLite datetime storage
);
-- 1.3 Insert all products where product_qty_type = 'unit' from the source table
INSERT INTO product_units ( product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp -- Explicitly include the timestamp column
)
SELECT product_id, product_name, product_size, product_category_id, product_qty_type, DATETIME('now') -- Generate and use the current timestamp
FROM product
WHERE product_qty_type = 'unit';

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

/*  STEP 2: ADD A NEW ROW  */
-- 2.1 Insert the desired product (e.g., Apple Pie) with a new timestamp
INSERT INTO product_units ( product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp
)
VALUES ( 9998, -- Unique ID 'Large Apple Pie', 'large', 7, -- Example category ID 'unit', DATETIME('now') 
);

#### DELETE 
1. Delete the older record for the whatever product you added.

**HINT**: If you don't specify a WHERE clause, [you are going to have a bad time](https://imgflip.com/i/8iq872).

<div align="center">-</div>

DELETE FROM product_units
WHERE product_name = 'Large Apple Pie'
  AND snapshot_timestamp < (
        SELECT MAX(snapshot_timestamp)
        FROM product_units
        WHERE product_name = 'Large Apple Pie'
      );


#### UPDATE
1. We want to add the current_quantity to the product_units table. First, add a new column, `current_quantity` to the table using the following syntax.
```
ALTER TABLE product_units
ADD current_quantity INT;
```

Then, using `UPDATE`, change the current_quantity equal to the **last** `quantity` value from the vendor_inventory details. 

**HINT**: This one is pretty hard. First, determine how to get the "last" quantity per product. Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) Third, `SET current_quantity = (...your select statement...)`, remembering that WHERE can only accommodate one column. Finally, make sure you have a WHERE statement to update the right row, you'll need to use `product_units.product_id` to refer to the correct row within the product_units table. When you have all of these components, you can run the update statement.
*** 

/*1. Add the new column to product_units*/
ALTER TABLE product_units
ADD COLUMN current_quantity INT;

/*2. Update current_quantity to the last (most recent) quantity per product*/
UPDATE product_units
SET current_quantity = COALESCE(
    (
        SELECT vi.quantity
        FROM vendor_inventory AS vi
        WHERE vi.product_id = product_units.product_id
        ORDER BY vi.market_date DESC
        LIMIT 1
    ),
    0
);

## Section 4:
You can start this section anytime.

Steps to complete this part of the assignment:
- Read the article
- Write, within this markdown file, <1000 words.

### Ethics

Read: Boykis, V. (2019, October 16). _Neural nets are just people all the way down._ Normcore Tech. <br>
    https://vicki.substack.com/p/neural-nets-are-just-people-all-the

**What are the ethical issues important to this story?**

Consider, for example, concepts of labour, bias, LLM proliferation, moderating content, intersection of technology and society, ect. 


```
The core ethical issue in this story is that “AI” is built on invisible people, then sold back to us as magic.

First, labor. ImageNet, WordNet, the Brown Corpus and similar resources are thousands of hours of human work: Turkers clicking labels for cents, grad students tagging parts of speech, linguists deciding which words count as synonyms. That labor is boring, underpaid, and mostly uncredited, while a tiny group of star researchers and companies capture the prestige and profit. Ethically, that is extraction, not “automation.”

Second, bias and classification. The hot-dog app is harmless, but the same pipeline is used to classify people. WordNet’s synsets and ImageNet’s “person” categories encode very specific cultural views about which labels exist and who fits them. Projects like ImageNet Roulette made visible how this turns into insulting or harmful tags on real faces. Those are not random bugs. They are the politics of race, gender, class and “normality” frozen into training data.

Third, deployment into social systems. These models now sit behind facial recognition for police, content moderation and recommendation algorithms. When the underlying labels and taxonomies are skewed, all of that skew shows up in who gets flagged, sorted or excluded in the real world.
Finally, even though the essay focuses on vision, the same pattern holds for LLMs. Giant text corpora, human raters, moderators and annotators are doing constant cleanup so that the model looks “smart” and “safe” on the surface.

So the ethical questions are: whose work is being used, on what terms, who defines the categories, and who gets hurt when those categories leak into policing, hiring or everyday platform use. Once you see that neural nets are people all the way down, it is hard to pretend this is just neutral technology.

```
