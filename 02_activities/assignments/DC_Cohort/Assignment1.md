# DC Assignment 1: Meet the farmersmarket.db and Basic SQL

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

#### Submission Parameters:
* Submission Due Date: `March 31, 2026`
* Weight: 30% of total grade
* The branch name for your repo should be: `assignment-one`
* What to submit for this assignment:
    * This markdown (Assignment1.md) with written responses in Section 4
    * One Entity-Relationship Diagram (preferably in a pdf, jpeg, png format).
    * One .sql file 
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pulls/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `assignment-one`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.

*** 

## Section 1:
You can start this section following *session 1*.

Steps to complete this part of the assignment:
- Load the farmersmarket.db and browse its content
- Create a logical data model

<br>
If this is your first time in DB Browser for SQLite, the following instructions may help:

#### 1) Load Database
- Open DB Browser for SQLite
- Go to File > Open Database
- Navigate to your farmersmarket.db 
	- This will be wherever you cloned the GH Repo (within the **05_src/sql** folder)
	- ![db_browser_for_sqlite_choose_db.png](./images/01_db_browser_for_sqlite_choose_db.png)

#### 2) Configure your windows
By default, DB Browser for SQLite has three windows, with four tabs in the main window and three tabs in the bottom right window
- Window 1: Main Window (Centre)
	- Stay in the Database Structure tab for now
- Window 2: Edit Database Cell (Top Right)
- Window 3: Remote (Bottom Right)
	- Switch this to DB Schema tab (very bottom)

Your screen should look like this (or very similar)
![db_browser_for_sqlite.png](./images/01_db_browser_for_sqlite.png)

#### 3) The farmersmarket.db
There are 10 tables in the Main Window:
1) booth
2) customer
3) customer_purchases
4) market_date_info
5) product
6) product_category
7) vendor
8) vendor_booth_assignments
9) vendor_inventory
10) postal_data

Switch to the Browse Data tab, booth is selected by default

<img src="./images/01_the_browse_data_tab.png" width="900">


Using the table drop down at the top left, explore some of the contents of the database

<img src="./images/01_the_table_drop_down_at_the_top_left.png" width="200">

Move on to the Logical Data Model task when you have looked through the tables


### Build Logical Data Model

Recall during session 1:

I diagramed the following four tables:
- product
- product_category
- vendor
- vendor_inventory

 <img src="./images/01_farmers_market_logical_model_partial.png" width="500">


#### Prompt 1:
Choose two tables and create a logical data model. There are lots of tools you can do this (including drawing this by hand), but I'd recommend [Draw.io](https://www.drawio.com/) or [LucidChart](https://www.lucidchart.com/pages/). 

A logical data model must contain:
- table name
- column names
- relationship type

Please do not pick the exact same tables that I have already diagrammed. For example, you shouldn't diagram the relationship between `product` and `product_category`, but you could diagram `product` and `customer_purchases`.

**HINTS**:
- You will need to use the Browse Data tab in the main window to figure out the relationship types.
- You can't diagram tables that don't share a common column
	- These are the tables that are connected
	- <img src="./images/01_farmers_market_conceptual_model.png" width="600">
- The column names can be found in a few spots (DB Schema window in the bottom right, the Database Structure tab in the main window by expanding each table entry, at the top of the Browse Data tab in the main window)

***

## Section 2:
You can start this section following *session 2*.

Steps to complete this part of the assignment:
- Open the assignment1.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment1.sql)
	- or, from your local forked repository  
- Complete each question, by writing responses between the QUERY # and END QUERY blocks

### Write SQL

#### SELECT
1. Write a query that returns everything in the customer table.
2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.

My code:
Q1
SELECT *
FROM customer;
Q2
SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

<div align="center">-</div>

#### WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9. Limit to 25 rows of output.
2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_per_quantity), filtered by customer IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN <br>
   Limit to 25 rows of output.

Q1
SELECT *
FROM customer_purchases
WHERE product_id=4 OR product_id=9
LIMIT 25;

Q2
SELECT *, quantity *cost_per_quantity AS price
FROM customer_purchases
WHERE product_id BETWEEN 8 AND 10
LIMIT 25;
second option:
SELECT *, quantity *cost_per_quantity AS price
FROM customer_purchases
WHERE product_id <=10 AND product_id>=8
LIMIT 25;

<div align="center">-</div>

#### CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”

2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.

Q1
SELECT product_id, product_name,
CASE 
WHEN product_qty_type='unit' THEN 'unit'
ELSE 'bulk'
END AS product_qty_type_condensed FROM product;

Q2
SELECT product_id, product_name, 
CASE WHEN product_qty_type='unit' THEN 'unit' ELSE 'bulk' END AS product_qty_type_condensed,
CASE WHEN product_name LIKE '%pepper%' THEN 1 ELSE 0 END AS pepper_flag
FROM product;

<div align="center">-</div>

#### JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `market_date` then `vendor_name`. Limit to 24 rows of output. 

SELECT vba.market_date, v.vendor_name FROM vendor_booth_assignments AS vba
INNER JOIN vendor AS v ON vba.vendor_id=v.vendor_id
ORDER BY vba.market_date, v.vendor_name
LIMIT 24;
***

## Section 3:
You can start this section following *session 3*.

Steps to complete this part of the assignment:
- Open the assignment1.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment1.sql)
	- or, from your local forked repository  
- Complete each question, by writing responses between the QUERY # and END QUERY blocks

### Write SQL

#### AGGREGATE
1. Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.
2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name.
   
**HINT**: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.

Q1
SELECT vendor_id, COUNT(booth_number)
FROM vendor_booth_assignments
GROUP BY vendor_id;

Q2
--customer table has list of customer names with customer_id as the identifier; customer purchases table has the list of purchases with customer_id as an identifier as well
--join customer to customer_purchases table on customer_id 
--create a new column total_spending which is quantity*cost_per_quantity from customer_purchases
--insert HAVING function to limit to total_spending >2000
--order by customer_last_name, customer_first_name from customer
SELECT c.customer_id, c.customer_last_name, c.customer_first_name, cp.quantity*cp.cost_per_quantity AS total_spending FROM customer as c
INNER JOIN customer_purchases AS cp ON c.customer_id = cp.customer_id
GROUP BY c.customer_id HAVING total_spending >2000
ORDER BY customer_last_name, customer_first_name;


<div align="center">-</div>

#### Temp Table
1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
   
**HINT**: This is two total queries -- first create the table from the original, then insert the new 10th vendor. When inserting the new vendor, you need to appropriately align the columns to be inserted (there are five columns to be inserted, I've given you the details, but not the syntax)

To insert the new row use VALUES, specifying the value you want for each column:  
`VALUES(col1,col2,col3,col4,col5)`

-- create a temp new table temp.new_vendor from vendor and add new entry using VALUES
CREATE TEMP TABLE  temp.new_vendor AS SELECT * FROM vendor;
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES(10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');
SELECT * FROM temp.new_vendor;


<div align="center">-</div>

#### Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
   
**HINT**: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are!

Limit to 25 rows of output. 

SELECT customer_id, STRFTIME('%m', market_date) AS purchase_month, STRFTIME('%Y', market_date) AS purchase_year
FROM customer_purchases
LIMIT 25;

2. Using the previous query as a base, determine how much money each customer spent in April 2022. Remember that money spent is `quantity*cost_per_quantity`.
   
**HINTS**: you will need to AGGREGATE, GROUP BY, and filter...but remember, STRFTIME returns a STRING for your WHERE statement...
AND be sure you remove the LIMIT from the previous query before aggregating!! 

SELECT customer_id, STRFTIME('%m', market_date) AS purchase_month, STRFTIME('%Y', market_date) AS purchase_year, quantity*cost_per_quantity AS customer_spending
FROM customer_purchases
WHERE purchase_month='04' AND purchase_year='2022'
GROUP BY customer_id LIMIT 25;

*** 

## Section 4:
You can start this section anytime.

Steps to complete this part of the assignment:
- Read the article
- Write, within this markdown file, between 250 and 1000 words. No additional citations/sources are required.

### Ethics

Read: Qadri, R. (2021, November 11). _When Databases Get to Define Family._  Wired. <br>
    https://www.wired.com/story/pakistan-digital-database-family-design/

Link if you encounter a paywall: https://archive.is/srKHV or https://web.archive.org/web/20240422105834/https://www.wired.com/story/pakistan-digital-database-family-design/

**What values systems are embedded in databases and data systems you encounter in your day-to-day life?**

Consider, for example, concepts of fariness, inequality, social structures, marginalization, intersection of technology and society, etc.


```
Your thoughts...
Many of the forms I fill out in Canada quietly encode values about who matters and how. Salutation fields, for instance, embed a social hierarchy: being listed as “Dr.” can bring privileges rooted in assumptions about one’s status, education, and credibility. Even the most routine identifiers, full name and date of birth, reflect a particular worldview about what makes a person legible to the state.

My mother’s story made this clear to me. She was born in a small village in Ethiopia in the 1960s, where names and birth dates were not formally recorded at birth. When she enrolled in elementary school in the capital city, she had to supply her own name and estimate her birthday. Hearing this, I realized how deeply these two data points are woven into the social structures of Western countries, and how developing nations have adopted them even where they do not align with traditional customs. Like the Pakistani family database Qadri describes, these systems do not simply record identity; they define it, and people whose lives do not fit the template must reshape themselves to be counted.

These identifiers are also imperfect on their own terms. Someone can use another person’s name, date of birth, and SIN to misrepresent themselves, which raises questions about whether they deserve the weight we give them. I am curious what alternative identification information a national database could use. An evolving biometric database is one intriguing possibility, though it would carry its own embedded values about bodies, consent, and surveillance that would need careful scrutiny.

```
