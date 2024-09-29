# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

![Question 1](https://github.com/user-attachments/assets/ccbb4f0e-de6a-486f-8b12-325e36f86ca7)

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![Question 2](https://github.com/user-attachments/assets/dcbd4a38-640b-43a7-8afd-143f71a358fb)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...
```

--Overwrite changes Type 1
DROP Table IF EXISTS CUSTOMER_ADDRESS;
CREATE TABLE CUSTOMER_ADDRESS (
    CustomerAddressID INT PRIMARY KEY,
	CustomerName VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(50),
    PostCode VARCHAR(10)
);

--Retain changes by adding new row, filter by Move_Out_Date Type 2
DROP Table IF EXISTS CUSTOMER_ADDRESS;
CREATE TABLE CUSTOMER_ADDRESS (
    CustomerAddressID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(50),
    PostCode VARCHAR(10),
    Move_In_Date DATE,
    Move_Out_Date DATE,
    IsCurrent BOOLEAN
);

Type 1 (Overwrite changes), minimal privacy implications. It shows the most recent address that stored as the historical record are not saved. However, current information still need to be safeguarded by only accessible for authorized people.
Type 2 (Retain changes), higher privacy implications. All the historical data as well as current address is on file. it means more detailed personal data are stored and the leaking risk exposure is higher than Type 1.

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```

1. Complexity
AdventureWorks: There are many tables stand for different entities and have numerous relationships. E.g. sales schema including few tables like salesPerson, Store, CreditCard, SalesTaxRate etc.
My ERD: it is less complexity with fewer tables and less relationships. For previous created Sales tables, it only includes few info like SalesID, OrderID etc.

2. Segmentation by using Schema
AdventureWorks: The schema is divided into 6 components, including sales/ purchasing/ person / production/ HR/ DBO, within each schema, it includes tables that related to specific business functions and make the graph more logically and easy to find specific function part.
My ERD: Not using schema to illustrate the segment, but instead having tables separately by following the guide. It makes the whole database less organized and hard to manage once the input data become more and more.

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
