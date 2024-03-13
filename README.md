# Data Storage and Access

Welcome! The course was created for the University of Toronto's Data Sciences Institute. It has been designed for individuals with no prior expertise in data science, empowering learners to thrive in today's data-driven world. 

## Contents:
1. [Description](https://github.com/UofT-DSI/02-intro_sql#description)
2. [Course Contacts](https://github.com/UofT-DSI/02-intro_sql#course-contacts)
3. [Learning Outcomes](https://github.com/UofT-DSI/02-intro_sql#learning-outcomes)
4. [Design](https://github.com/UofT-DSI/02-intro_sql#design)
5. [Expectations](https://github.com/UofT-DSI/02-intro_sql#expectations)
6. [Policies](https://github.com/UofT-DSI/02-intro_sql#policies)
7. [Schedule](https://github.com/UofT-DSI/02-intro_sql#schedule)
8. [Folder Structure](https://github.com/UofT-DSI/02-intro_sql#folder-structure)
9. [Acknowledgements](https://github.com/UofT-DSI/02-intro_sql#acknowledgements)

## Description

SQL is used across the machine learning pipeline, and a fundamental skill for data scientists to master. This course will focus on the technical skills needed for working with SQL, including flat-file datasets (JSON, CSV) ingestion, query design, and relational database management. Additionally, it will examine common data management concerns, data access management, and data privacy adherence.

Learners are first introduced to data modelling and how to think about the structure of databases. The majority of the course is devoted learning the necessary commands and their syntax to properly extract information from database. Throughout the entire course, students will learn how to problem solve through live coding. 

## Course Contacts
- Instructor: Emails to Thomas (he/him) can be sent to [thomas.rosenthal@utoronto.ca](mailto:thomas.rosenthal@utoronto.ca)
- TAs: Emails to Ananya (she/her) can be sent to [ananya.jha@mail.utoronto.ca](mailto:ananya.jha@mail.utoronto.ca). Additional support, Vishnou Vinayagame (he/him) [vishnouvina@cs.toronto.edu](mailto:vishnouvina@cs.toronto.edu)

## Learning Outcomes
1. Develop a better understanding of the structure of databases.
2. Save and transport data in CSV and JSON file formats.
3. Familiarity with the essentials of querying and manipulating data in SQL and how to search for future questions.
4. Familiarity with the legal framework around sharing data.
5. Analyze data requirements and work with different stakeholders such as analysts and managers.

## Design

The course runs synchronously over Zoom. It consists of six classes. Classes are 6 PM - 830 PM EST on Tuesday and Wednesday for select dates. Being mindful of online fatigue, there will be one or two breaks during each class where students are encouraged to stretch, grab a drink and snacks, or ask any additional questions.  

**Tutorials**: sessions with both TAs will also be offered over Zoom. These will take place 30 minutes before and after each session.  

**Pedagogy**: This course will use a dedicated _Etherboard_ for student collaboration. The link will be provided in the first class. New content will be added by the instructor before each session. Each session will consist of slides to introduce topics, live coding to demonstrate the topics, and occasional breakout rooms/live polls to reinforce the topics.  

## Expectations
The course is designed for both live-coding and corresponding slides. Students should follow along with the coding, interact with the study material [SQL for Data Scientists by Renee Teate](https://sqlfordatascientists.com/), and think about the broader data landscape. Students are encouraged to ask questions throughout. 

### Technology Requirements
- A computer with internet access is required to attend sessions and participate in live-coding.
- Download DB Browser for SQLite here: https://sqlitebrowser.org/dl/
- Downloading R and/or Python is not required but encouraged, please see the respective DSI repositories for instructions on installing these languages and your preferred IDE.

## Policies
- Accessibility: We want to provide an accessible learning environment for all. If there is something we can do to make this course more accessible to you, please let us know.
- Course communications: Essential communications take place over email. Please include "DSI-SQL" or similar in the subject line.
- Camera: Keeping your camera on is welcomed, but optional.
- Microphone: Please keep microphones muted unless you need to speak. Questions are highly encouraged.
- Slack: Use the DSI Slack to keep up to date and ask and answer questions. Please be respectful and follow the code of conduct while communicating on Slack.

## Schedule (subject to change)

| Lecture | Date | Topic | Slides |
| --- | --- | --- | --- |
| 0 | Before First Lecture | Install & Pre-Class | [Setup](https://github.com/UofT-DSI/02-sql/blob/main/SQL/SQLite%20Setup.pdf) |
| 1 | Tues, February 20 <br> 6 - 8:30 PM EST | Introduction, Data Modelling, Schema Design, Data Structures | [Introduction](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_01.pdf) |
| 2 | Wed, February 21 <br> 6 - 8:30 PM EST | Building Queries: SELECT, FROM, WHERE, CASE, DISTINCT, JOINs | [Building Queries](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_02.pdf) |
| 3 | Tues, February 27 <br> 6 - 8:30 PM EST | Essential Techniques: Aggregation Functions, Subqueries, Temporary Tables, CTEs, Datetime Functions | [Essential Techniques](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_03.pdf)|
| 4 | Wed, February 28 <br> 6 - 8:30 PM EST | Advanced Techniques: NULL Management, Windowed Functions, String Manipulation, UNION & UNION ALL, INTERSECT & EXCEPT | [Advanced Techniques](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_04.pdf) |
| 5 | Tues, March 12 <br> 6 - 8:30 PM EST | Expanding your Database: INSERT, UPDATE, DELETE, Importing & Exporting Data, CROSS & Self Joins, Views | [Expanding your Database](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_05.pdf) |
| 6 | Wed, March 13 <br> 6 - 8:30 PM AM EST | Beyond SQL: Ethics, Normal Forms, SQLite in R & python | [Beyond SQL](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_06.pdf) |

## Assignments

Grading is pass/fail. There is only one assignment and six short (but mandatory) homeworks. Class Participation is 12% of the final grade. Submit via your Google Drive using lastname_firstname_SQL_HW#.

| Assessment	|  Due Date | SQL | Weight |
| --- | --- | --- | --- |
| [Assignment 1](https://github.com/UofT-DSI/02-sql/blob/main/Assignments/Assignment%201%20-%20Design%20a%20Logical%20Model.pdf) | Sat, March 23, by 11:59 PM EST | [Rubric](https://github.com/UofT-DSI/02-sql/blob/main/Assignments/Assignment%201%20Rubric.pdf) | 40% |
| [Homework 1 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_1/Homework%201.pdf) | Thurs, February 22, by 11:59 PM EST |  ¯\\\_(ツ)_/¯ | 8% |
| [Homework 2 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_2/Homework%202.pdf) | Sat, February 24, by 11:59 PM EST | [Homework 2 SQL](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_2/Homework%202.sql) | 8% |
| [Homework 3 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_3/Homework%203.pdf) | Sat, March 2, by 11:59 PM EST | [Homework 3 SQL](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_3/Homework%203.sql) | 8% |
| [Homework 4 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_4/Homework%204.pdf) | Sat, March 2, by 11:59 PM EST | [Homework 4 SQL](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_4/Homework%204.sql) | 8% |
| [Homework 5 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_5/Homework%205.pdf) | Sat, March 16, by 11:59 PM EST | [Homework 5 SQL](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_5/Homework%205.sql) | 8% |
| [Homework 6 PDF](https://github.com/UofT-DSI/02-sql/blob/main/Homework/module_6/Homework%206.pdf) | Sat, March 16, by 11:59 PM EST | (╯°□°）╯︵ ┻━┻ | 8% |

## Folder Structure
Below are the folders contained in this repo with a description of what they contain and information on how to use them.

### 1. *Slides*: 
Slides were built in R with `xaringan`. Output files are HTML.

### 2. *PDFs*:
PDF version of slides, using `renderme`. Some minor differences may exist.

### 3. *SQL*: 
FarmersMarket.db, in-class SQL codes.

### 4. *Data*: 
Data (csv, json, etc) we'll use for importing.

### 5. *Homework*:
Homework to be done after each module.

### 6. *Assignments*:
Rubrics and assignment details.

## Acknowledgements

First slides were originally developed by [Faria Khandaker](https://fariak.ca) and [Paul Hodgetts](https://hodgettsp.com) under the supervision of [Rohan Alexander](https://rohanalexander.com). Great suggestions were made by [A Mahfouz](https://github.com/amfz) and [Lorena Almaraz](https://github.com/lalmaraz). Slides have been created and modified by [Thomas](https://github.com/mrpotatocode) in 2022, 2023, and 2024.
