# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?
Option 1: Overwriting Changes (Type 1 SCD):
CUSTOMER_ADDRESS Table (Type 1):
Columns:
customer_id (Primary Key)
address_line_1
address_line_2
city
state
postal_code
In this model, when a customer's address changes, the previous address is overwritten. No historical record is kept of the old address.

Option 2: Retaining Changes (Type 2 SCD):
CUSTOMER_ADDRESS Table (Type 2):
Columns:
customer_id (Primary Key)
address_line_1
address_line_2
city
state
postal_code
start_date
end_date
In this model, whenever a customer’s address changes, a new row is created with the updated address and the old record is marked with an end_date. This approach keeps a historical record of all changes.

```
Your answer...
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
1. Complexity in Order and Sales Data:
AdventureWorks: It separates sales data into SalesOrderHeader (order-level data) and SalesOrderDetail (item-level data). This allows for better granularity and flexibility in recording detailed sales transactions.
Bookstore Model: In contrast, the bookstore’s Order table and Sales table combine these responsibilities, which could be expanded if more detail is needed.
2. Customer Relationships:
AdventureWorks: Includes a detailed system for customer relationships with various sales territories and salespersons.
Bookstore Model: This is simpler and does not include sales territory information or customer relationships with salespeople. However, this could be useful if the bookstore expands to serve larger geographic regions.
Changes You Might Consider:
Introduce a SalesOrderHeader and SalesOrderDetail structure to better handle order data granularity.
Add sales territories or region management if the bookstore begins operating across multiple areas.

```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
