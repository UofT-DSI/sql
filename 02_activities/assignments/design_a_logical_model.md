# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

![question_1](https://github.com/user-attachments/assets/e95df9a3-604b-4c67-a676-7c422156f9a1)


## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![question_2](https://github.com/user-attachments/assets/d42b5379-ea5b-45af-8e0f-bf915b088ffb)


## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
A Type-1 “slowly changing dimension” is one where the old data in a row is deleted and replaced with new data, so we lose the history of the changes within a particular row4

A Type-2 “slowly changing dimension” is one where the old data is preserved since new data gets inserted as a brand new row, rather than modifying the old row

A type-1 architecture for the customer’s address table, would be one that overwrites the existing data. This would be a simpler table to create, since we only need to capture the data within a single row like so:
```

![image](https://github.com/user-attachments/assets/afc6e6db-fa49-4b56-8eb2-c28683e990e1)

```
A type-2 architecture for the customer’s address table, would be one where we need to keep track of all historical records of address changes for each customer. To do this, we would need a way to know which address is valid by searching for all entries related to a specific customer_id, then selecting the date_id of the most recent entry in the list:
```

![image](https://github.com/user-attachments/assets/a65bedad-ce7b-4f70-a85f-e0d3807c81d3)


## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Differences:

-	It groups unique columns using a convention of (U1, U2, etc) for clusters of unique columns and (FK1, FK2, etc) for clusters of distinct foreign keys
-	The entity diagram defines clusters of tables into separate schemas making it easier to identify inputs and outputs across domains (e.g. HumanResources and Person)
-	I am guessing that bolded columns are ones that cannot be NULL. For example, in the Address table, you must have an AddressLine1 (it cannot be NULL), but AddressLine2 is optional (it can be NULL); therefore, only AddressLine1 is bolded. This is a good way of providing context in a simple and concise way.
-	I am guessing that the underlined columns are ones that have indexes. Since all of the primary keys are underlined. The columns that are underlined could be ones that get searched often and therefore need to be indexed

How would I incorporate some of these changes into my own graph?

I would update the entity diagram to include bolding to indicate NULLABLE fields, and an indicator of unique (U) columns. I would create distinct schemas, so that there is some structure and organization as new tables get added. For example, the employees table could belong to a HumanResources schema and Orders could belong to the Purchasing schema. This would also allow us to secure our tables a bit more, because only a select few people should have access to the tables within HumanResources.

I also like the way the Person table breaks down the CountryRegion and StateProvince into distinct tables to make the data more condensed. I used an address column, which would have included a lot of repetition in the province and country text. This can all be replaced with a foreign key reference to an ID.
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
