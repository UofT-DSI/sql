# Assignment 1: Design a Logical Model

## Question 1

## Question 2
Employee - Shift Relationship is One-to-Many since each shift can have multiple employees working on it, and each employee is assigned to one shift at a time.

## Question 3
First table is a Type 1 Slowly Changing Dimension because we overwrite the existing address without keeping historical data.
Second table is a Type 2 Slowly Changing Dimension because it keeps a history of changes to the address.

Bonus: Retaining a customer's address history (as in Type 2) may raise privacy concerns because it involves storing personal data over a long period. If a customer moves, they may not want their old address kept on record. Compliance with data privacy regulations like GDPR may require that old addresses are deleted or anonymized.

## Question 4
Differences between my model and AdventureWorks:
In AdventureWorks, product information is split across multiple tables (e.g., Product, ProductModel, ProductCategory). In my diagram I can keep everything in one Book table. I might consider splitting the Book table into Book, Genre, and Publisher to mimic the structure in AdventureWorks. AdventureWorks also includes detailed customer demographic data (e.g., income group, marital status), whereas my diagram only captures basic customer info like name and email. I could consider expanding the Customer table to include more detailed demographic data.

Would I change anything in your design?
I could further normalize the diagram by splitting Book data into separate tables (e.g., Genre, Author) for better scalability. I could also include customer demographics to improve marketing and sales analysis but may raise ethical concerns around privacy.





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
