# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

```
Note: publication date for the book in book table, can be also in relation to date table, but since there is probably not much qurries over this information, this relation was not made.
```

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

```
Note: for this part I could've added only one table and included employee_id in that, but as the book store grows, the number of employees working in shifts will grow too which makes redundant data in shift table. same thing goes for the shift type but as it has only two different possible values, it is kept in the main shift table and not in the shift_details.
```

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?

```
for the sake of simplicity, let's imagine that address_details will be only one column (in reality it is a combination of multiple columns such as: address line1, address line2, street, city, etc.).
Now for the architectures, type 1:
TABLE CUSTOMER_ADDRESS COLUMNS address_id, address_details, customer_id, last_updated_date
in type 1 structure, as soon as the customer changes address, the values for address_details, last_updated_date will be updated. Note that address_id has been added as addresses entities can be shared by different costumers such as roommates or family members.
type 2:
TABLE CUSTOMER_ADDRESS COLUMNS address_id, address_details, customer_id, is_current, start_date, end_date
in this type as soon as a new costumer signs up or and old one changes address a new row will be created. for the address change, the columns is_current and end_date of previous address entity of that costumers will be updated too, respectively from 'TRUE' to 'FALSE' and from NULL to current_date. this will create a historical record of address entities.

Bonus answer: probably yes, as in type 2 we are holding more data.
1. our business might not even need this data, so its not only more expensive to manage, maintain and keep safe, it also has legal issues based on the regulations. A historical data of people address is really sensitive, and if it is not an essential element of the business it can be legally problematic.
2. in case of request from the customer to delete their data, again it is more demanding as we have to make sure all the data relevant to this costumer has been deleted successfully and if not it might be a reason to be sued. :)
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?

```
1. having the partition and table named person . any person has some general information, such as firstname, lastname, age, gender, etc. Each employee for instance, is considered a person with some added extra details which is stored in the HR part of the schema in employee table. this will definitely improve the performance of the data structure. it also reduces redundancy as the data base gets bigger and bigger. for example big companies such as Walmart who have a large set of employees, will have redundant data as a good proportion of their employees are their costumers too, if they don't use such schema.

2. same thing for a table named business entity and also business entity as the primary key of many tables. any vendor, costumer, employee, store, salesman is a business entity. I am not sure about this one but it adds a layer of distinctness amongst entities, like a large scale ID system. (there are no individual id columns for tables such as vendor, person, employee, etc.)

reflection:
Both ideas are really close and highly dependant on the scale of the data. I am more intrigued about implementing the second idea in my ERD beacuse It doesn't add complexity to the data structre (less filtering and joining to get credential of costumers for instance.). for the first idea, a new table person has to be crafted and costumer details table and employee details table would be children of this table.
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
- [x] Create a branch called `model-design`.
- [x] Ensure that the repository is public.
- [x] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [x] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
