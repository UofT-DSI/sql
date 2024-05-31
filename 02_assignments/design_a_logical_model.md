# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).
![Q1](https://github.com/movcha/sql/assets/29900189/f001e449-3961-4dbc-9242-7ec49637ff42)

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.
![Q2](https://github.com/movcha/sql/assets/29900189/7a1287fd-e671-4756-85f5-03fa535d2f10)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._
![Q3](https://github.com/movcha/sql/assets/29900189/07ab7045-5485-4e0c-9fb5-da7124ebd198)

Bonus: Are there privacy implications to this, why or why not?
```
Storing customer addresses, particularly over time, raises privacy concerns. Personal information should be handled according to data protection regulations like GDPR back in Europe or PIPEDA here in Canada. Storing historical addresses (Type 2) may pose higher risks if data is breached, so proper security measures must be implemented.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
AdventureWorks schema is more complex with a greater number of tables and relationships to support a large enterprise. It uses color types that make it easier to navigate. AdventureWorks includes specialized tables like SalesOrderHeader and ProductModelIllustration, indicating a detailed order processing system and a wide range of products.
I would include scalability options for future expansion of the bookstore’s offerings or services but still maintain simplicity for ease of use and understanding.
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
- [X] Create a branch called `model-design`.
- [X] Ensure that the repository is public.
- [X] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [X] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
