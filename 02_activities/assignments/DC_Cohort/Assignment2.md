# DC Assignment 2: Design a Logical Model and Advanced SQL

🚨 Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md) 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

#### Submission Parameters:

* Submission Due Date: `April 07, 2026`
* Weight: 70% of total grade
* The branch name for your repo should be: `assignment-two`
* What to submit for this assignment:

  * This markdown (Assignment2.md) with written responses in Section 1 and 4
  * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
  * One .sql file
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pulls/<pr_id>`

  * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:

* [ ] Create a branch called `assignment-two`.
* [ ] Ensure that the repository is public.
* [ ] Review the PR description guidelines and adhere to them.
* [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack. Our Technical Facilitators and Learning Support staff are here to help you navigate this assignment.

---

## Section 1:

You can start this section following session 1, but you may want to wait until you feel comfortable with basic SQL query writing.

Steps to complete this part of the assignment:

* Design a logical data model
* Duplicate the logical data model and add another table to it following the instructions
* Write, within this markdown file, an answer to Prompt 3

### Design a Logical Model

#### Prompt 1

Design a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized.

Additionally, include a date table.

A date table (also called a calendar table) is a permanent table containing a list of dates and various components of those dates.

ERD: See the submitted ERD image for the logical model.

#### Prompt 2

We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

ERD: See the submitted ERD image for the updated logical model with employee shifts.

#### Prompt 3

The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

There are two possible architectures for the CUSTOMER_ADDRESS table, depending on whether the bookstore wants to keep a history of address changes.

Type 1 — Overwrite changes

In a Type 1 design, the customer's existing address is updated when they provide a new address. The table could contain columns such as customer_address_id, customer_id, street, city, province, postal_code, and country. If a customer moves, their old address is replaced with the new address. This approach is simple and only keeps the customer's current address, but it does not preserve any history of previous addresses.

Type 2 — Retain changes

In a Type 2 design, a new record is created whenever a customer's address changes, while the previous address remains in the table. The table could contain customer_address_id, customer_id, street, city, province, postal_code, and country, as well as start_date, end_date, and is_current. When the customer moves, the previous record can be given an end date and marked as no longer current, while a new record is created with the new address and a new start date. This allows the bookstore to maintain a complete history of the customer's addresses.

Therefore, Type 1 overwrites the existing address and does not retain historical changes, while Type 2 creates new records and retains the history of address changes. Type 2 is useful when the bookstore needs to know where a customer lived at a particular point in time, while Type 1 is sufficient when only the customer's current address is important.

---

## Section 2:

You can start this section following session 4.

Steps to complete this part of the assignment:

* Open the assignment2.sql file in DB Browser for SQLite.
* Complete each question by writing responses between the QUERY and END QUERY blocks.

### Write SQL

#### COALESCE

1. Our favourite manager wants a detailed long list of products, but is afraid of tables! We tell them, no problem! We can produce a list with all of the appropriate details.

Using the following syntax you create our super cool and not at all needy manager a list:

```sql
-- QUERY

SELECT
    product_name || ', ' ||
    COALESCE(product_size, '') || ' (' ||
    COALESCE(product_qty_type, 'unit') || ')'
FROM product;

-- END QUERY
```

But wait! The product table has some bad data (a few NULL values). Find the NULLs and then using COALESCE, replace the NULL with a blank for the first column with nulls, and 'unit' for the second column with nulls.

```sql
-- QUERY

SELECT
    product_name || ', ' ||
    COALESCE(product_size, '') || ' (' ||
    COALESCE(product_qty_type, 'unit') || ')'
FROM product;

-- END QUERY
```

#### Windowed Functions

### 1. Number each customer's visits

```sql
-- QUERY

SELECT
    customer_id,
    market_date,
    DENSE_RANK() OVER (
        PARTITION BY customer_id
        ORDER BY market_date
    ) AS visit_number
FROM customer_purchases
WHERE market_date < '2022-04-29';

-- END QUERY
```

### 2. Reverse the numbering and find the most recent visit

```sql
-- QUERY

SELECT *
FROM (
    SELECT
        customer_id,
        market_date,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY market_date DESC
        ) AS visit_number
    FROM customer_purchases
)
WHERE visit_number = 1;

-- END QUERY
```

### 3. Count how many times each customer purchased each product

```sql
-- QUERY

SELECT
    customer_id,
    product_id,
    market_date,
    COUNT(*) OVER (
        PARTITION BY customer_id, product_id
    ) AS purchase_count
FROM customer_purchases
WHERE market_date < '2022-04-29';

-- END QUERY
```

#### String manipulations

### 1. Extract the product description

```sql
-- QUERY

SELECT
    product_name,
    CASE
        WHEN INSTR(product_name, '-') > 0
        THEN TRIM(
            SUBSTR(
                product_name,
                INSTR(product_name, '-') + 1
            )
        )
        ELSE NULL
    END AS description
FROM product;

-- END QUERY
```

### 2. Filter product sizes containing a number

```sql
-- QUERY

SELECT
    product_name,
    product_size
FROM product
WHERE product_size REGEXP '[0-9]';

-- END QUERY
```

#### UNION

### 1. Market dates with the highest and lowest total sales

```sql
-- QUERY

WITH daily_sales AS (
    SELECT
        market_date,
        SUM(quantity * cost_per_quantity) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),
ranked_sales AS (
    SELECT
        market_date,
        total_sales,
        RANK() OVER (
            ORDER BY total_sales DESC
        ) AS best_day,
        RANK() OVER (
            ORDER BY total_sales ASC
        ) AS worst_day
    FROM daily_sales
)
SELECT
    market_date,
    total_sales
FROM ranked_sales
WHERE best_day = 1

UNION

SELECT
    market_date,
    total_sales
FROM ranked_sales
WHERE worst_day = 1;

-- END QUERY
```

---

## Section 3:

You can start this section following session 5.

Steps to complete this part of the assignment:

* Open the assignment2.sql file in DB Browser for SQLite.
* Complete each question by writing responses between the QUERY and END QUERY blocks.

### Write SQL

#### Cross Join

### 1. Calculate vendor earnings per product

Suppose every vendor in the vendor_inventory table had 5 of each of their products to sell to every customer on record. How much money would each vendor make per product? Show this by vendor_name and product name, rather than using the IDs.

```sql
-- QUERY

SELECT
    v.vendor_name,
    p.product_name,
    SUM(5 * vi.cost_per_quantity) AS total_sales
FROM (
    SELECT DISTINCT
        vendor_id,
        product_id,
        cost_per_quantity
    FROM vendor_inventory
) vi
JOIN vendor v
    ON vi.vendor_id = v.vendor_id
JOIN product p
    ON vi.product_id = p.product_id
CROSS JOIN (
    SELECT DISTINCT
        customer_id
    FROM customer
) c
GROUP BY
    v.vendor_name,
    p.product_name;

-- END QUERY
```

#### INSERT

### 1. Create the product_units table

```sql
-- QUERY

CREATE TABLE product_units AS
SELECT
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

-- END QUERY
```

### 2. Insert another product record

```sql
-- QUERY

INSERT INTO product_units (
    product_id,
    product_name,
    product_size,
    product_category_id,
    product_qty_type,
    snapshot_timestamp
)
SELECT
    product_id,
    product_name,
    product_size,
    product_category_id,
    product_qty_type,
    CURRENT_TIMESTAMP
FROM product
WHERE product_name = 'Apple Pie';

-- END QUERY
```

#### DELETE

### 1. Delete the older Apple Pie record

```sql
-- QUERY

DELETE FROM product_units
WHERE product_name = 'Apple Pie'
AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp)
    FROM product_units
    WHERE product_name = 'Apple Pie'
);

-- END QUERY
```

#### UPDATE

### 1. Add the current_quantity column

```sql
-- QUERY

ALTER TABLE product_units
ADD current_quantity INT;

-- END QUERY
```

### 2. Update current_quantity using the latest inventory quantity

```sql
-- QUERY

UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(vi.quantity, 0)
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    ORDER BY vi.market_date DESC
    LIMIT 1
)
WHERE product_units.product_id IS NOT NULL;

-- END QUERY
```

---

## Section 4:

You can start this section anytime.

Steps to complete this part of the assignment:

* Read the article
* Write, within this markdown file, between 250 and 1000 words. No additional citations/sources are required.

### Ethics

Read: Boykis, V. (2019, October 16). Neural nets are just people all the way down. Normcore Tech.

What are some of the ethical issues important to this story?

The article “Neural nets are just people all the way down” shows that machine learning systems are not completely independent or objective. Even though we often think of AI as something that is powered mainly by computers and algorithms, the article explains that humans play an important role in creating the data used to train these systems. People manually label images, organize categories, and make decisions about how information should be classified. These human decisions can introduce bias into the data and, as a result, into the machine learning system.

One important ethical issue is that biased or inappropriate training data can lead to unfair outcomes. For example, the article discusses ImageNet and how some categories used to label people were considered offensive or sensitive. If an AI system learns from these labels, it may reproduce the same biases when making predictions about new people. This demonstrates that even if an algorithm is technically working as designed, the results can still be harmful if the data or categories used to train it are problematic.

Another important issue is the human labour involved in creating AI systems. People are needed to collect, clean, label, and moderate data before it can be used to train machine learning models. This work can be repetitive and sometimes involve exposure to disturbing or inappropriate content. It is important to recognize this labour and consider whether workers are being treated fairly and provided with appropriate working conditions.

I think this means that people who create and use machine learning systems have a responsibility to think carefully about the data they use. They should check training data for bias, remove harmful or inappropriate categories where appropriate, and consider how different groups of people could be affected by the system. It is also important to have diverse people involved in designing and reviewing these systems because different perspectives can help identify problems that one group might overlook.

Overall, the article changed the way I think about AI because it shows that technology is not automatically neutral just because a computer is making the decision. Human choices exist throughout the process, from collecting and labeling data to designing the model and deciding how its results are used. Therefore, building responsible AI requires not only good technology but also careful human judgment, fairness, transparency, and accountability.
