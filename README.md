# DSI Workshop for Data Storage and Access

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
This curriculum was created for the University of Toronto's Data Science Institute. It is designed for learners who have a degree in something other than Computer Science/Statistics and are looking to enhance their data science skills for their career.

SQL is used across the machine learning pipeline, and a fundamental skill for data scientists to master. This course will focus on the technical skills needed for working with SQL, including flat-file datasets (JSON, CSV) ingestion, query design, and relational database management. Additionally, it will examine common data management concerns, data access management, and data privacy adherence.

Learners are first introduced to data modelling and how to think about the structure of databases. The majority of the course is devoted learning the necessary commands and their syntax to properly extract information from database. Throughout the entire course, students will learn how to problem solve through live coding. 

Additionally, the course will explore SQL databases in everyday life, and how R and Python interact with SQL databases when performing statistical analysis or machine learning tasks. Learners will be introduced to principles around reproducibility, sharing data, and data ethics (for example, respecting those whose data we use). This course will also cover professional skills such as communication (with a variety of stakeholders) and documentation. 


## Course Contacts
- Instructor: Emails to Thomas (he/him) can be sent to [twillrose@proton.me](mailto:twillrose@pm.me)
- TA: Emails to Salaar (he/him) can be sent to [s.liaqat@mail.utoronto.ca](mailto:s.liaqat@mail.utoronto.ca)

## Learning Outcomes
1. Develop a better understanding of the structure of databases.
2. Save and transport data in CSV and JSON file formats.
3. Familiarity with the essentials of querying and manipulating data in SQL and how to search for future questions.
4. Familiarity with the legal framework around sharing data.
5. Analyze data requirements and work with different stakeholders such as analysts and managers.

## Design
The course runs synchronously over Zoom. It consists of three classes a week for three weeks (nine classes total). Classes are 6 PM - 8 PM EST on Mondays and Thursdays, and 9 AM - 12 PM EST on Saturdays. Being mindful of online fatigue, there will be one or two breaks during each class where students are encouraged to stretch, grab a drink and snacks, or ask any additional questions.  

Tutorial sessions with a TA will also be offered over Zoom. These will take place from 5 PM - 6 PM EST on Mondays and Thursdays, and 8:30 AM - 9 AM EST and 12 PM - 12:30 PM EST on Saturdays.  

## Expectations
The course is designed for both live-coding and corresponding slides. Students should follow along with the coding, interact with the study marterial [SQL for Data Scientists by Renee Teate](https://sqlfordatascientists.com/), and think about the broader data landscape. Students are encouraged to ask questions throughout. 

### Technology Requirements
- A computer with internet access is required to attend sessions and participate in live-coding.
- Download DB Browser for SQLite here: https://sqlitebrowser.org/dl/


## Policies
- Accessiblity: We want to provide an accessible learning environment for all. If there is something we can do to make this course more accessible to you, please let us know.
- Course communications: Communications take place over email. Please include "DSI-SQL" or similar in the subject line.
- Camera: Keeping your camera on is welcomed, but optional.
- Microphone: Please keep microphones muted unless you need to speak. Questions are highly encouraged.
- Assessment: Each class there will be reccomended homework which is not graded. There will be three assignments which are graded.  

## Schedule (subject to change)
Day 1: Introduction, Data Modelling, Schema Design, Data Structures

Day 2: Building Queries: SELECT, FROM, WHERE, CASE, DISTINCT, JOINs

Day 3: Essential Techniques: Aggregation Functions, Subqueries, Temporary Tables, CTEs, Datetime Functions, ISNULL

Day 4: Advanced Techniques: Windowed Functions, String Manipulation, CROSS & Self Joins, UNION & UNION ALL, INTERSECT & EXCEPT

Day 5: Expanding your Database: INSERT, UPDATE, DELETE, Importing & Exporting Data, Normal Forms, Views

Day 6: SQL and the Machine Learning pipeline, SQL in R & python

Day 7: Broader Data Landscape, Reproducibility, Ethics, SQL in the wild

Day 8: Professional Skills - Industry Case Study

Day 9: Review and Practice, TBD

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

### 5. *Code*:
In-class R and python codes.

### 6. *Homework*:
Homework to be done after each module.

### 7. *Assignments*:
Rubrics and assignment details.

## Acknowledgements

Slides were originally developed by [Faria Khandaker](https://fariak.ca) and [Paul Hodgetts](https://hodgettsp.com) under the supervision of [Rohan Alexander](https://rohanalexander.com). Great suggestions were made by [A Mahfouz](https://github.com/amfz) and [Lorena Almaraz](https://github.com/lalmaraz). Slides have been modified by [Thomas](https://github.com/mrpotatocode) for 2023.
