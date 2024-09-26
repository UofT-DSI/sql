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
```
First Approach : Overwrite
In this approach, the customer address in the database will bet updated everytime any modification is madewithout retaining the different/old address versions. In short, only the latest or the current address details will  be stored. The disadvantage of this approach is, it will be impossible to track the changes if any such requirement arises. The advantage is it needs only less storage as for each customer, only one address will be stored.

Second approach: Retain changes
In this case, every time a customer address is modified, a new entry will be created. So, the history of changes will be tracked along with what was updated, when it was updated etc can be stored. THe disadvantage is, a customer can have multiple address entries and it consumes more storage. As a result, it can become complex to handle large dataset and it is necessary to include columns to indicate if the address is current or not. You can also include fields likie temporary address or permanenet address.

In both the approaches there are risks involves as it holds personal data of the customers. These information are confidential and should allow access to only authorized users to protect it. 

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```
The AdventureWorks Schema is a large database design which has categorized into multiple schemas such as sales, person, production etc and has captured a wide range of data that we could think of in a real scenario. It has defined many possible relationships and tagged the primary key and foreign key. It is grouped thoughtfully with much clarity. For example, Human Resources - It has taken into consideration of employees info, employee shifts, department, employee department history, emplpoyee pay history etc. 
Each schema is unique but they are interconnected with other schemas.
Since a lot of information is captured, it would be useful when retrieving reports from the database as they are interconnected.

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
