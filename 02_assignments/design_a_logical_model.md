# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
A Slowly Changing Dimension (SCD) is a table which can be updated to keep up 
with changing data. I propose to implement an SCD for customer addresses called
'customer_addresses'. The table's columns will include customer_id, a one-to-one
key with the customer table, as well as columns for Street Address, Suite, City,
State, Country, and Zip Code.

An SCD can have type 1 architecture or type 2 architecture. Suppose customer_addresses
were implemented in type 1. Then a change of address update will overwrite the old
data in the table or create a new entry if the customer_address is new. 

In the other case, suppose that customer_addresses were implemented with type 2 
architecture. Then a customer_address update will always create a new row. 
Additionally, one of the customer_addresses columns tracks whether the record is 
the current address. 

Bonus: 
Meaningful consent to collect private information requires the option to refuse 
to disclose. The schema should accomodate this refusal and permitting no 
address in the record in a way that does not break query tasks like JOINS.

As well, include a privacy consent flag which can be updated ongoing.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
I noticed the use of AddressID keyed to StateProvince on  StateProvinceID is 
used to determine the tax rate. I find that especially clever for implementing 
online sales. 

The employee table included a lot more information and was missing names!
employee table was keyed to Person on BusinessEntityID, and Person tracks 
6 columns detailing every part of a person's salutation. Instead of naming
employee table at AdventureWorks tracks states like shift, job title,
hire date, salariedflag, and two types of paid time off. I would copy these
items and leave out the private information like MaritalStatus column.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [x] Create a branch called `model-design`.
- [x] Ensure that the repository is public.
- [x] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [x] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
