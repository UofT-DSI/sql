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
Type 1 SCD  Overwrite Changes 
The CUSTOMER_ADDRESS table overwrites the existing address whenever there is an update. Historical addresses are not retained, and only the current address is stored.

This design minimizes the amount of personal information stored, as only the current address is kept. This can be beneficial for privacy as it reduces the risk of exposure of historical addresses in the event of a data breach.
However, it does not provide a history of address changes, which can be a drawback if historical address information is needed for business purposes or legal compliance.

Type 2 SCD Retain Changes
The CUSTOMER_ADDRESS table retains historical addresses by adding a new record each time an address changes. 

This design stores a complete history of address changes, which can be valuable for customer service and compliance purposes.
However, retaining historical address data increases the amount of personal information stored, which can heighten privacy risks.

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```
AdventureWorks provides a robust and detailed schema that exemplifies best practices in database design, such as high normalization and comprehensive historical tracking. 

Difference 1: Scope
AdventureWorks: Extensive and highly detailed, with separate tables for distinct aspects of business operations, reflecting real-world complexity. Separate tables for different attributes. Highly normalized with multiple related tables for each entity. 
Bookstore ERD: More simplified with fewer tables and combined data fields to ease implementation. For example: Customer table combining customer and email and phone number without historical tracking for the email and phone number.

Difference 2: Historical Data Tracking
AdventureWorks: Implements Type 2 SCD to track historical data, maintaining comprehensive records of changes over time.
Bookstore ERD: Type 1 SCD. It lacks mechanisms to retain historical data and updates that overwrite previous information.

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
