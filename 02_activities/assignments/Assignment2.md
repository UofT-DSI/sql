# Assignment 2: Design a Logical Model and Advanced SQL

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

#### Submission Parameters:
* Submission Due Date: `February 1, 2025`
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

#### Prompt 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

#### Prompt 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2? 

**HINT:** search type 1 vs type 2 slowly changing dimensions. 

```
Your answer...
```
I provided my answer on the png file. Essentially, the use of new columns that indicate activation and deactivation dates will allow changes to be retained. This is the second table on the png file. 
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
Find the NULLs and then using COALESCE, replace the NULL with a blank for the first problem, and 'unit' for the second problem. 

**HINT**: keep the syntax the same, but edited the correct components with the string. The `||` values concatenate the columns into strings. Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. All the other rows will remain the same.

<div align="center">-</div>

#### Windowed Functions
1. Write a query that selects from the customer_purchases table and numbers each customer’s visits to the farmer’s market (labeling each market date with a different number). Each customer’s first visit is labeled 1, second visit is labeled 2, etc. 

You can either display all rows in the customer_purchases table, with the counter changing on each new market date for each customer, or select only the unique market dates per customer (without purchase details) and number those visits. 

**HINT**: One of these approaches uses ROW_NUMBER() and one uses DENSE_RANK().

2. Reverse the numbering of the query from a part so each customer’s most recent visit is labeled 1, then write another query that uses this one as a subquery (or temp table) and filters the results to only the customer’s most recent visit.

3. Using a COUNT() window function, include a value along with each row of the customer_purchases table that indicates how many different times that customer has purchased that product_id.

<div align="center">-</div>

#### String manipulations
1. Some product names in the product table have descriptions like "Jar" or "Organic". These are separated from the product name with a hyphen. Create a column using SUBSTR (and a couple of other commands) that captures these, but is otherwise NULL. Remove any trailing or leading whitespaces. Don't just use a case statement for each product! 

| product_name               | description |
|----------------------------|-------------|
| Habanero Peppers - Organic | Organic     |

**HINT**: you might need to use INSTR(product_name,'-') to find the hyphens. INSTR will help split the column. 

<div align="center">-</div>

#### UNION
1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

**HINT**: There are a possibly a few ways to do this query, but if you're struggling, try the following: 1) Create a CTE/Temp Table to find sales values grouped dates; 2) Create another CTE/Temp table with a rank windowed function on the previous query to create "best day" and "worst day"; 3) Query the second temp table twice, once for the best day, once for the worst day, with a UNION binding them. 

***

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

#### INSERT
1. Create a new table "product_units". This table will contain only products where the `product_qty_type = 'unit'`. It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  Name the timestamp column `snapshot_timestamp`.

2. Using `INSERT`, add a new row to the product_unit table (with an updated timestamp). This can be any product you desire (e.g. add another record for Apple Pie). 

<div align="center">-</div>

#### DELETE 
1. Delete the older record for the whatever product you added.

**HINT**: If you don't specify a WHERE clause, [you are going to have a bad time](https://imgflip.com/i/8iq872).

<div align="center">-</div>

#### UPDATE
1. We want to add the current_quantity to the product_units table. First, add a new column, `current_quantity` to the table using the following syntax.
```
ALTER TABLE product_units
ADD current_quantity INT;
```

Then, using `UPDATE`, change the current_quantity equal to the **last** `quantity` value from the vendor_inventory details. 

**HINT**: This one is pretty hard. First, determine how to get the "last" quantity per product. Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) Third, `SET current_quantity = (...your select statement...)`, remembering that WHERE can only accommodate one column. Finally, make sure you have a WHERE statement to update the right row, you'll need to use `product_units.product_id` to refer to the correct row within the product_units table. When you have all of these components, you can run the update statement.

*** 

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
Your thoughts...
```
“I consider myself a (relatively) educated person, but I simply had no idea that mostly people were making my clothes.”

Introduction. The above metaphorical introduction to the hidden role of people in creating the architecture of large learning models (LLMs), including training data sets, learning images and linguistic databases, recalled for me a similar phenomenon that exists in relation to food, wherein most Americans (and presumably citizens in many western countries) never seek information about where or how (and hence by whom) their food was grown and that “much of the … public remains disengaged or misinformed about food”.  

Indeed, I’m confident that similar statements can be made respecting many (most? almost all?) of the outputs of modern industrial production. Why? Because the structure of modern production of industrial goods and services shares many common features. Specifically, that structure is characterized by its economies of (and hence large) scale, labour specialization, standardization, high capital investment, efficiency and complexity.

In dissecting this apparent lack of knowledge respecting human contributions to the goods and services that form the sustenance of our lives and modern societies, my intention is to illustrate that despite the ethical efforts to “remedy fairness issues” contemplated in the article, the best that the technological structure around most modern production may allow is what might be called “performative fairness.” We can gain some insight into these issues by unpacking the complexities in the contributions made to the  LLMs discussed in the article.

Modern technological complexity. I had to chuckle a little when I arrived at the supposed end of the article author’s pursuit of the underlying contributions to modern LLMs by exclaiming “Ok! Now we’re at the bottom” once she’d arrived at the Brown Corpus developed in the early 1960s. What the author arrived at was not the bottom of anything but rather the edge of the study boundary for her inquiry into fairness respecting attribution to the development of a typical LLM. To be charitable, an inquiry study boundary needs to be drawn somewhere, but it’s instructive to investigate what remains vertically and horizontally outside the author’s chosen study boundary. 

Examples of vertical exclusions include prior contributions to Brown Corpus (e.g., the “books, magazines, newspapers, and other edited sources of informative and imaginative prose published in 1961”), or additional contributions beyond Brown’s Corpus to WordNet, including “various dictionaries, various word corpuses, and manual classification”, or for that matter additional (unmentioned, though certainly present) contributions to ImageNet beyond WordNet.

The horizontal contributions to the development of LLMs are almost endless, especially when considered in the context of the vertical contributions over time. Examples of horizontal contributions include: the research funders, the institutional workers supporting the research, the developers and maintainers of the public and private infrastructure (e.g., university and corporate buildings, energy, telecommunications, computing components, etc.), and the public services necessary to support modern endeavours (e.g., transportation, healthcare, etc.). Beyond corporate logos and “made in Country” labels, these contributions are almost entirely unidentified and unacknowledged, may only be identifiable and acknowledgeable with considerable effort and cost, and may in fact be impossible to acknowledge.

Life’s (no longer just) a peach. Returning to food, I’ll end with a metaphorical example of my own. When my grandmother was a young woman, she lived on a small acreage where she and my grandfather grew tender fruit, including cherries, plums and peaches. Fertilizer used on the peach trees came in the form of manure from local animals on their own and other local farms. All the peach trees were maintained and harvested by local labour, including families, neighbours and seasonable workers. Almost all, if not all, the farms were locally owned and operated. For additional wages, my grandmother walked a mile every day from her home to work in the local factory where baskets were manufactured for use in local farms throughout the region. Every fresh peach she ever ate was grown within a few miles of her home. If my grandmother wanted to acknowledge those responsible for the many contributions to the fresh peaches she and her family enjoyed, with few exceptions she need not go much further than the local region.

My nephews, who live about a half-mile from my grandparent’s property (which several years ago ceased to be an active farm), can still obtain a peach grown within a couple miles of their home. Today, those peach trees are the product of several decades of genetic research at regional and national research centres. While they produce higher yields, they are more susceptible to mildews and require greater use of herbicides and pesticides. They are fertilized with both organic and fossil-fuel based fertilizers brought in from distant regions. Almost all the peach trees are maintained and harvested by foreign workers into plastic buckets imported from overseas. Every time my nephews eat a locally grown peach, they can probably still locate the lands on which the peach was grown, but many of the farmlands are now corporately owned and finding the farmer could be difficult. If my nephews wished to acknowledge those responsible for the various contributions to the fresh peaches they enjoy, with few exceptions, they would need to go to great efforts.

In summary, I think that the author’s effort, namely, to acknowledge those who have contributed to modern LLMs (or for that matter to any modern good or service) to be admirable. It reflects a universal desire to ensure fairness, to acknowledge contributions and to express gratitude. The characteristics of modern technological production, including their complexities, make that process very challenging.
