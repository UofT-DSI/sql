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
Your answer...
Type 1 slow changing dimension (SCD) architecture:

Customer_address table columns: address_id(primary key), customer_id(foreign key), address, city, province, country, postal_code

Type 1 slowly changing dimension is a method where the existing value is overwritten with the new value and does not retain history. This method can be used to update customer addresses where the old address is not deemed important for it to be recorded or is not historically significant. When Type 1 is used to update customer addresses, the previous addresses will be overwritten and only the new one will be saved.
Each customer address added to the table of customer_address will get its new row regardless of when they occur as this type of SCD doesn’t retain history.


Type 2 slow changing dimension (SCD) architecture:

Customer_address table columns: address_id(primary key), customer_id(foreign key), address, city, province, country, postal_code, start_date, end_date 

Type 2 slowly changing dimension adds a new row for the new value and maintains the existing row for historical and reporting purposes. The old customer addresses point to all addresses prior to the change and the new address is the current one saved. This can be done by effective dating both the new and old addresses and assigning the new address a new surrogate key. This will also give an idea when the customer moved to this address.
Each customer address change results in a new row being inserted into the customer_address table with a new start_date. The end date of the last address is updated to clearly show when the address came into effect.

Privacy implications:
The address of customers are personally identifiable information which can have potential privacy implications if not stored correctly. Careful compliance with privacy regulations such as GDPR and CCPA should be maintained while handling this sensitive data. Unauthorised access should be avoided to protect the data from being used beyond the scope of the business in this case for the bookstore purposes i.e. order fulfillment or customer communication. Failure to adequately protect customer address data could lead to breaches of privacy and trust, as well as legal consequences for the bookstore.



 



```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```The Advetureworks ERD shows the relationship between the different schemas within it e.g. Sales, purchasing, person, production, human resources, dbo etc. The differences between the AdvetureWorks ERD and the bookstore ERD are listed below:
1.	All the tables having common attributes within a specific department are listed together and have a different yet unique background color. For examples sales, production and purchasing departments are categorised separately and the color-coded background only shows the tables within those categories. In my bookstore ERD, I have not differentiated the various departments within the bookstore with a different color. 
2.	The description of each of the attributes is also given like data types for example PK, FK1, FK2, U1, U2. I have not included the data types in my own bookstore ERD.
3.	There is a greater number of tables and hence more entity relationships per table between them as well. Different schemas are linked together through entity relationships. My own bookstore ERD only contains 9 tables.


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
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
