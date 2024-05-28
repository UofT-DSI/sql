# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

Answer: diagram attached in this folder "bookstore.png"
[Customer] 1 — ∞ [Order]
  customer_id         customer_id
  first_name
  last_name
  email
  phone_number
  address

[Order] 1 — ∞ [Sales]
  order_id              order_id
  customer_id
  order_date
  status
  total_amount

[Employee] 1 — ∞ [Sales]
  employee_id           employee_id
  first_name
  last_name
  email
  phone_number
  hire_date
  position
  salary

[Book] 1 — ∞ [Sales]
  book_id               book_id
  title
  author
  genre
  isbn
  price
  stock_quantity
  publisher
  publication_date

[Sales]
  sale_id
  order_id
  employee_id
  book_id
  quantity
  sale_price


## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE Employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (employee_id)
);

CREATE TABLE Customer (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    PRIMARY KEY (customer_id)
);

CREATE TABLE Book (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    isbn VARCHAR(20) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    publisher VARCHAR(100),
    publication_date DATE,
    PRIMARY KEY (book_id)
);

CREATE TABLE `Order` (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Sales (
    sale_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    employee_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (sale_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE EmployeeShift (
    shift_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    shift_date DATE NOT NULL,
    shift_type ENUM('morning', 'evening') NOT NULL,
    PRIMARY KEY (shift_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);



## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...
```
Type 1 SCD (Overwrites Changes)
In the Type 1 design (CustomerAddress_Type1), whenever a customer's address is updated, the old address is simply overwritten by the new address. This means that the street_address, city, state, postal_code, and country fields will always contain the current address. The last_updated column helps track when the address was last modified. This design is simple and uses less storage, but it does not retain historical data.

Type 2 SCD (Retains Changes)
In the Type 2 design (CustomerAddress_Type2), a new record is inserted for each address change. The start_date indicates when the address became valid, and the end_date marks when it was replaced by a new address (or is NULL if it is the current address). The is_current flag helps quickly identify the current address. This design retains all historical addresses, enabling the business to track address changes over time, but it requires more storage and involves more complex queries to retrieve the latest address.

Type 1 SCD involves overwriting old data with new data. This method does not maintain historical data; the current data is always up-to-date.

Table: CustomerAddress_Type1
address_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
customer_id (Foreign Key): INT, NOT NULL
street_address: VARCHAR(255), NOT NULL
city: VARCHAR(100), NOT NULL
state: VARCHAR(100), NOT NULL
postal_code: VARCHAR(20), NOT NULL
country: VARCHAR(100), NOT NULL
last_updated: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
Type 2 SCD (Retains Changes)
Type 2 SCD involves creating a new record for each change, thus retaining historical data. This method adds new rows to maintain historical records.

Table: CustomerAddress_Type2
address_scd_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
customer_id (Foreign Key): INT, NOT NULL
street_address: VARCHAR(255), NOT NULL
city: VARCHAR(100), NOT NULL
state: VARCHAR(100), NOT NULL
postal_code: VARCHAR(20), NOT NULL
country: VARCHAR(100), NOT NULL
start_date: DATE, NOT NULL
end_date: DATE, DEFAULT NULL
is_current: BOOLEAN, NOT NULL, DEFAULT TRUE

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```
1. Schema Segmentation and Complexity
AdventureWorks:

Segmentation: 
AdventureWorks schema is divided into multiple schemas, such as Sales, Purchasing, Person, Production, HumanResources, and dbo, each encapsulating related tables. This segmentation helps organize the database logically, enhancing maintainability and security by restricting access to specific parts of the database.
Complex Relationships: The AdventureWorks ERD includes complex relationships with numerous tables having many-to-many relationships managed through junction tables. For instance, SalesOrderHeader and SalesOrderDetail tables manage orders, linking customers, products, and sales details in a structured way.

Bookstore ERD:
Single Schema: The bookstore ERD consists of a single schema containing all tables (Employee, Customer, Book, Order, Sales, EmployeeShift). This simpler structure is easier to manage for smaller applications but can become unwieldy as the business grows.

Simpler Relationships: Relationships in the bookstore ERD are relatively straightforward, primarily one-to-many relationships. For instance, Order to Sales, Customer to Order, and Book to Sales do not include intermediate tables for complex many-to-many relationships.

2. Normalization Level and Surrogate Keys
AdventureWorks:
High Normalization: The AdventureWorks database is highly normalized. For instance, instead of storing addresses directly in the Customer table, addresses are stored in a separate Address table, linked through the Person schema. This eliminates redundancy and maintains consistency.
Surrogate Keys: The database extensively uses surrogate keys (e.g., PersonID, ProductID, AddressID), ensuring unique identifiers that are stable and efficient for indexing and querying.

Bookstore ERD:
Moderate Normalization: The bookstore ERD uses a moderate level of normalization. For example, while it has separate tables for entities like Customer, Book, and Order, it does not separate address information or other related details into distinct tables.

Primary Keys: It uses primary keys but might mix natural keys and surrogate keys. For example, isbn in the Book table could serve as a natural key, whereas other tables might use auto-incremented integers.
Suggested Changes to the Bookstore ERD:
Introduce Separate Schemas: Implementing schema segmentation, similar to AdventureWorks, could enhance the organization and manageability of the bookstore database. For example:

Sales Schema: Containing Order and Sales tables.
Person Schema: Containing Customer and Employee tables.
Inventory Schema: Containing Book and any related inventory tables.

Higher Normalization:
Address Normalization: Create a separate Address table linked to Customer and Employee tables. This can store address details and link through foreign keys, reducing redundancy.
Junction Tables for Many-to-Many Relationships: If the bookstore deals with situations like multiple authors for books or customers with multiple addresses, junction tables should be introduced to manage these relationships effectively.

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
