# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).



## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.
![alt text](<Assignment - SQL-Q1&2.drawio.png>)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?



_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
![alt text](<Assignment - SQL-Q3.drawio.png>)
```
Type 1 (Overwrite):

Minimal privacy concerns because only the latest address is kept in the database.
Once the old address is overwritten, it no longer exists in the system.
Benefit: Limits exposure of customer data to only the current address, reducing potential privacy risks from historical data breaches.

Type 2 (Retain Changes):

Higher privacy implications due to the retention of all historical addresses.
Even after a customer updates their address, their previous addresses remain stored, which could pose a privacy risk if the data is breached or misused.
Risk: Retaining outdated personal data without clear consent might violate data protection laws like GDPR or CCPA, especially if the information is not essential for business purposes. Customers might expect that old addresses are removed once updated.
Mitigation: Consider adding expiration policies for old records and clearly inform customers if historical data is kept for specific reasons (e.g., fraud detection, audits).

If you implement Type 2 (retaining historical data), you should consider how long to keep this data and whether to inform customers explicitly that their past addresses will be stored. Some jurisdictions might require you to delete historical data unless there’s a legitimate business reason to retain it. Data minimization principles (as in GDPR) suggest keeping the least amount of data necessary to achieve business purposes, which might argue against a Type 2 approach unless required.

```

## Question 4
Review the AdventureWorks Schema [here](https://imgur.com/a/u0m8fX6)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Two Key Differences Between AdventureWorks and My Bookstore ERD:
Product Entity Granularity:

AdventureWorks: It has a highly normalized schema for products, with separate tables for product details, product categories, product models, and product reviews. The schema captures detailed aspects of products, such as descriptions, categories, and versions.
My Bookstore ERD: The Book table is relatively simpler, with fields like book_id, title, author, genre, and price, and it does not break down into additional categories like AdventureWorks does.
Would I Change It?
Yes, depending on the complexity and needs of the bookstore. If the bookstore were to expand and start carrying multiple types of products (e.g., non-book items like stationery, or different formats of books such as ebooks and audiobooks), it might make sense to normalize the product data further and break it down into multiple tables like in AdventureWorks. For example, I could add separate tables for Book Format or Book Categories to handle these distinctions in more detail.

Sales and Order Entities:

AdventureWorks: AdventureWorks has a much more sophisticated system for handling sales and orders. It includes tables like SalesOrderHeader, SalesOrderDetail, and SalesTerritory. Sales are broken down into detailed components, with specific headers and details, along with the assignment of sales to territories and salespeople.
My Bookstore ERD: My bookstore schema combines the Order and Sales concepts in a simpler way. The Sales table tracks order details but doesn't have the level of granularity found in AdventureWorks, such as assigning sales to territories or sales representatives.
Would I Change It?
I would consider making changes if the bookstore plans to expand its business to operate multiple locations or regions. Introducing sales territories or separating out the Order Header and Order Details (like in AdventureWorks) would allow for better tracking of large-scale sales operations. For example, I could separate Order into Order_Header and Order_Detail to more effectively capture order-level information vs. line-item details.
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


[def]: image.png