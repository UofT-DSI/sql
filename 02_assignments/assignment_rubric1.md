# Assignment 1: Design a Logical Model Rubric

## General
  - Criteria: Participant Name on Assignment
  - Criteria: Written content is no longer than two pages
  - Criteria: Assignment is free of noticeable typos
  - Criteria: Two ERDs exist

## Question 1

  - **Tables**
    - Employee: Relates to employees.
    - Order: Relates to order processing.
    - Sales: Relates to sales transactions.
    - Customer: Relates to customer information.
    - Book: Relates to inventory of books.

  - **Tables Exist**: All five tables need to exist.
  - **Column Relevance**: Each table must have named columns that relate to their respective entities and include columns relevant for bookstore administration. (**🚨EACH table out will be graded as complete or incomplete🚨**)
  - **Relationships Indicated**: Clear relationships between the aforementioned tables must be established.
  - **Date Table**: 
    - Must exist with typical columns.
    - Must have correct relationships with other relevant tables indicated.

Database: bookstore
Table: Employee
employee_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
first_name: VARCHAR(50), NOT NULL
last_name: VARCHAR(50), NOT NULL
email: VARCHAR(100), NOT NULL, UNIQUE
phone_number: VARCHAR(15)
hire_date: DATE, NOT NULL
position: VARCHAR(50), NOT NULL
salary: DECIMAL(10, 2), NOT NULL
Table: Customer
customer_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
first_name: VARCHAR(50), NOT NULL
last_name: VARCHAR(50), NOT NULL
email: VARCHAR(100), NOT NULL, UNIQUE
phone_number: VARCHAR(15)
address: VARCHAR(255)
Table: Book
book_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
title: VARCHAR(255), NOT NULL
author: VARCHAR(100), NOT NULL
genre: VARCHAR(50)
isbn: VARCHAR(20), NOT NULL, UNIQUE
price: DECIMAL(10, 2), NOT NULL
stock_quantity: INT, NOT NULL
publisher: VARCHAR(100)
publication_date: DATE
Table: Order
order_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
customer_id (Foreign Key): INT, NOT NULL
order_date: DATE, NOT NULL
status: VARCHAR(50), NOT NULL
total_amount: DECIMAL(10, 2), NOT NULL
Table: Sales
sale_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
order_id (Foreign Key): INT, NOT NULL
employee_id (Foreign Key): INT, NOT NULL
book_id (Foreign Key): INT, NOT NULL
quantity: INT, NOT NULL
sale_price: DECIMAL(10, 2), NOT NULL
Relationships
Customer to Order: One-to-Many (One customer can place multiple orders)
Order to Sales: One-to-Many (One order can have multiple sales entries, one per book sold)
Employee to Sales: One-to-Many (One employee can handle multiple sales)
Book to Sales: One-to-Many (One book can appear in multiple sales entries)
    
    
    
    
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


## Question 2
- Employee Shift Table exists, and we can discern morning/evening shifts from its design**

Table: EmployeeShift
shift_id (Primary Key): INT, NOT NULL, AUTO_INCREMENT
employee_id (Foreign Key): INT, NOT NULL
shift_date: DATE, NOT NULL
shift_type: ENUM('morning', 'evening'), NOT NULL

Employee to EmployeeShift: One-to-Many (One employee can have multiple shifts)


## Question 3: 
- Two distinct architectures are proposed**
- One design for Customer Addresses table would retain changes**
- One design for Customer Addresses table would overwrite changes**
- Each architecture is properly labelled as either Type 1 or Type 2 SCD**
    - Both Correct (Complete)
    - One Wrong (Incomplete)
    - Both Wrong (Incomplete)

Type 1 SCD (Overwrites Changes)
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

Explanation of the Designs
Type 1 SCD (Overwrites Changes)
In the Type 1 design (CustomerAddress_Type1), whenever a customer's address is updated, the old address is simply overwritten by the new address. This means that the street_address, city, state, postal_code, and country fields will always contain the current address. The last_updated column helps track when the address was last modified. This design is simple and uses less storage, but it does not retain historical data.

===========
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

Type 2 SCD (Retains Changes)
In the Type 2 design (CustomerAddress_Type2), a new record is inserted for each address change. The start_date indicates when the address became valid, and the end_date marks when it was replaced by a new address (or is NULL if it is the current address). The is_current flag helps quickly identify the current address. This design retains all historical addresses, enabling the business to track address changes over time, but it requires more storage and involves more complex queries to retrieve the latest address.


## Question 4: 
- AdventureWorks ERD has been examined**
- Two interesting differences between participant ERDs and AdventureWorks ERDs highlighted**
- Student reflection on differences between the ERDs**

Having examined the AdventureWorks ERD, I identified two notable differences when compared to the participant ERDs:

1. **Normalization and Table Granularity**:
   - **AdventureWorks**: The AdventureWorks ERD is highly normalized, with many tables breaking down entities into their smallest components. For example, the `Person` table is further divided into `PersonPhone`, `EmailAddress`, and `PersonAddress`. This allows for a highly efficient and organized way to store data, reduce redundancy, and maintain data integrity.
   - **Participant ERDs**: In contrast, participant ERDs often combine related attributes into fewer tables, leading to less granularity. For instance, instead of separate tables for phone numbers and email addresses, a participant's ERD might include all contact information within a single `Customer` table. This approach can simplify the design but might introduce data redundancy and make it harder to enforce data integrity.

2. **Use of Surrogate Keys**:
   - **AdventureWorks**: The AdventureWorks database extensively uses surrogate keys (usually integers, such as `PersonID`, `ProductID`, etc.) as primary keys. These surrogate keys are system-generated and not derived from any application data. This practice ensures that keys are unique, immutable, and stable.
   - **Participant ERDs**: Participant ERDs often use natural keys, which are meaningful data (like email addresses or composite keys) as primary keys. While natural keys can provide context and are easier to understand, they can change over time, which may lead to difficulties in maintaining database integrity and relationships.

###Student Reflection

Reflecting on the differences between the participant ERDs and the AdventureWorks ERD highlights important considerations in database design:

1. **Normalization and Granularity**:
   - **Pros of AdventureWorks Approach**: The high level of normalization in AdventureWorks ensures data consistency and minimizes redundancy. It also makes the database more scalable and easier to maintain. For example, updating a phone number in a normalized structure ensures that all references to that phone number are updated across the database, eliminating inconsistencies.
   - **Cons of AdventureWorks Approach**: However, such a detailed breakdown can make the database more complex to design and query. It requires a deeper understanding of relationships and often necessitates more complex joins in SQL queries to retrieve meaningful information.
   - **Participant Perspective**: The more combined approach in participant ERDs can be easier to understand and implement initially. It simplifies querying by reducing the number of joins required to fetch related data. However, it risks data anomalies and redundancy. For example, storing multiple addresses directly in the `Customer` table can lead to duplicate address entries and make updating information cumbersome.

2. **Surrogate vs. Natural Keys**:
   - **Pros of Surrogate Keys**: Surrogate keys, as used in AdventureWorks, provide a simple, stable, and consistent method for uniquely identifying records. They are immune to changes in business logic or data values and can significantly enhance performance by using single-column integer keys for indexing.
   - **Cons of Surrogate Keys**: The main drawback is that they are not meaningful outside the database context, which can sometimes make debugging and understanding the data more challenging.
   - **Participant Perspective**: Using natural keys can make the database more intuitive, as keys are derived from actual data. For example, using an email address as a primary key immediately identifies the entity being referenced. However, natural keys can change, leading to potential issues with referential integrity and cascading updates.

### Conclusion

The AdventureWorks ERD demonstrates a highly structured and efficient approach to database design, emphasizing normalization and the use of surrogate keys to ensure data integrity and performance. In contrast, participant ERDs tend to favor simplicity and intuitive design, often at the expense of scalability and robustness. This reflection underscores the importance of balancing complexity, performance, and ease of use in database design, considering the specific needs and context of the application.

## Criteria

|Criteria|Complete|Incomplete|
|--------|----|----|
|Question 1 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 2 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 3 Requirements|All requirements are met.|At least one requirement is not met.|
|Question 4 Requirements|All requirements are met.|At least one requirement is not met.|
