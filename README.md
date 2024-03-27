# Data Storage and Access

Welcome! The module was created for the University of Toronto's Data Sciences Institute. It has been designed for individuals with no prior expertise in data science, empowering learners to thrive in today's data-driven world. 

## Content

* [Description](#description)
* [Module Contacts](#module-contacts)
* [Learning Outcomes](#learning-outcomes)
* [Delivery of Module](#delivery-of-module)
  + [How the Technical Facilitator will deliver](#how-the-technical-facilitator-will-deliver)
* [Expectations](#expectations)
* [Requirements](#requirements)
* [Policies](#policies)
* [Schedule (subject to change)](#schedule-subject-to-change)
* [Assignments](#assignments)
* [Resources](#resources)
  + [Documents](#documents)
  + [Videos](#videos)
  + [How to get help](#how-to-get-help)
* [Folder Structure](#folder-structure)
* [Acknowledgements](#acknowledgements)

## Description

SQL is used across the machine learning pipeline, and a fundamental skill for data scientists to master. This module will focus on the technical skills needed for working with SQL, including flat-file datasets (JSON, CSV) ingestion, query design, and relational database management. Additionally, it will examine common data management concerns, data access management, and data privacy adherence.

Learners are first introduced to data modelling and how to think about the structure of databases. The majority of the module is devoted learning the necessary commands and their syntax to properly extract information from database. Throughout the entire module, students will learn how to problem solve through live coding. 

## Module Contacts

**Questions can be submitted to the #questions channel on Slack**

* Technical Facilitator: **{Name}** {Pronouns}. Emails to the Technical Facilitator can be sent to {first_name.last_name}@mail.utoronto.ca.
* Learning Support Staff: **{Name}** {Pronouns}. Emails to the Technical Facilitator can be sent to {first_name.last_name}@mail.utoronto.ca.

## Learning Outcomes
By the end of the module, learners will:

**Week 1:**
1. Describe the structure of a database.
2. Use an export command to save and transport data in CSV and JSON file formats.
3. Use SQL querying and data manipulation techniques to formulate queries for diverse purposes.

**Week 2:**
4. Examine the legal framework around sharing data.
5. Analyze data requirements and work with different stakeholders such as analysts and managers.
6. Use advanced techniques such as String Manipulation, and NULL Management to manipulate results.

## Delivery of Module
The module will run sychronously three times a week on Zoom. The first three days are used as "lectures" and will last a maximum of 3 hours. During this time, the Technical Facilitator will introduce the concepts for the week. The last two days are used for as optional, asychronous work periods. The work periods will also last for up to 3 hours. During these two days, an Technical Facilitator or TA will be present on Zoom to assist learners reach the intended learning outcomes.

**Tutorials**: sessions with both TAs will also be offered over Zoom. These will take place 30 minutes before and after each session.  

**Pedagogy**: This module will use a dedicated _Etherboard_ for student collaboration. The link will be provided in the first class. New content will be added by the Technical Facilitator before each session. Each session will consist of slides to introduce topics, live coding to demonstrate the topics, and occasional breakout rooms/live polls to reinforce the topics.  

### How the Technical Facilitator will deliver
The Technical Facilitators will introduce the concepts through a collaborative live coding session using SQLite. All Technical Facilitators will also upload any live coding files to this repository for any learners to revisit under `/live-code`.

## Expectations
The module is designed for both live-coding and corresponding slides. Students should follow along with the coding, interact with the study material [SQL for Data Scientists by Renee Teate](https://sqlfordatascientists.com/), and think about the broader data landscape. Students are encouraged to ask questions throughout. 

## Requirements
* Learners are not expected to have any coding experience, we designed the learning contents for beginners.
* Learners are encouraged to ask questions, and collaborate with others to enhance learning.
* Learners must have a computer and an internet connection to participate in online activities.
* Learners will be using https://sqlitebrowser.org/dl/ for their SQL work
* Learners must not use generative AI such as ChatGPT to generate code in order to complete assignments. It should be use as a supportive tool to seek out answers to questions you may have.
* We expect learners to have completed the [onboarding repo](https://github.com/UofT-DSI/Onboarding/tree/tech-onboarding-docs).
* Camera is optional although highly encouraged. We understand that not everyone may have the space at home to have the camera on.

## Policies
* **Accessibility:** We want to provide an accessible learning environment for all. If there is something we can do to make this module more accessible to you, please let us know.
* **Module communications:** Communications take place over email or on Slack. If communicating over email, please include "DSI-SQL" or similar in the subject line, e.g. "DSI-SQL: CTE question"
* **Camera:** Keeping your camera on is optional.
* **Microphone:** Please keep microphones muted unless you need to speak. Please indicate your name before speaking as some Zoom configurations make it hard to tell who is talking!
* **Assessment:** There will be homework which **is not** graded, but highly recommended, and there will be two assignments which **are** graded.

## Schedule (subject to change)

| Lecture | Date | Topic | Slides |
| --- | --- | --- | --- |
| 0 | Before First Lecture | Install & Pre-Class | [Setup](https://github.com/UofT-DSI/02-sql/blob/main/SQL/SQLite%20Setup.pdf) |
| 1 | TBA | Introduction, Data Modelling, Schema Design, Data Structures | [Introduction](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_01.pdf) |
| 2 | TBA | Building Queries: SELECT, FROM, WHERE, CASE, DISTINCT, JOINs | [Building Queries](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_02.pdf) |
| 3 | TBA | Essential Techniques: Aggregation Functions, Subqueries, Temporary Tables, CTEs, Datetime Functions | [Essential Techniques](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_03.pdf)|
| 4 | TBA | Advanced Techniques: NULL Management, Windowed Functions, String Manipulation, UNION & UNION ALL, INTERSECT & EXCEPT | [Advanced Techniques](https://github.com/UofT-DSI/02-sql/blob/main/PDFs/slides_04.pdf) |
| 5 | TBA | Expanding your Database: INSERT, UPDATE, DELETE, Importing & Exporting Data, CROSS & Self Joins, Views | [Expanding your Database]() |
| 6 | TBA | Beyond SQL: Normal Forms, SQL and the Machine Learning pipeline, Broader Data Landscape, Reproducibility, Ethics, SQL in the wild | [Beyond SQL]() |

## Assignments

Grading is pass/fail. There is only one assignment and six short (but mandatory) homeworks. Class Participation is 12% of the final grade. Submit via your Google Drive using lastname_firstname_SQL_HW#.

| Assessment	|  Due Date | SQL |
| --- | --- | --- |
| Assignment 1   | TBA |                |
| Homework 1 PDF | TBA |  ¯\\\_(ツ)_/¯  |
| Homework 2 PDF | TBA | Homework 2 SQL |
| Homework 3 PDF | TBA | Homework 3 SQL |
| Homework 4 PDF | TBA | Homework 4 SQL |
| Homework 5 PDF | TBA | Homework 5 SQL |
| Homework 6 PDF | TBA | Homework 6 SQL |

## Resources
Feel free to use the following as resources:

### Documents
- [Cheatsheet](https://www.sqlitetutorial.net/sqlite-cheat-sheet/)
- [W3Schools Tutorial](https://www.w3schools.blog/sqlite-tutorial)

### Videos
- [What is SQLite?](https://www.youtube.com/watch?v=p2tOmltUh34)
- [SQLite Playlist](https://www.youtube.com/playlist?list=PLWENznQwkAoxww-cDEfIJ-uuPDfFwbeiJ)

### How to get help
![image](/steps-to-ask-for-help.png)

<hr>

## Folder Structure

```markdown
.
├── 01-slides
├── 02-assignments
├── 03-homework
├── 04-instructors
├── 05-data
├── 06-sql
├── LICENSE
├── README.md
└── steps-to-ask-for-help.png
```

* **Slides:** Slides were built in markdown. Output files are HTML.
* **PDFs:** PDF version of slides, using `renderme`. Some minor differences may exist.
* **SQL:** FarmersMarket.db, in-class SQL codes.
* **Data:** Data (csv, json, etc) we'll use for importing.
* **Homework:** Homework to be done after each module.
* **Assignments:** Rubrics and assignment details.
* **Instructors:** Instructions for the Technical Facilitator on what to teach
* README: This file!
* .gitignore: Files to exclude from this folder, specified by the Technical Facilitator

## Acknowledgements

First slides were originally developed by [Faria Khandaker](https://fariak.ca) and [Paul Hodgetts](https://hodgettsp.com) under the supervision of [Rohan Alexander](https://rohanalexander.com). Great suggestions were made by [A Mahfouz](https://github.com/amfz) and [Lorena Almaraz](https://github.com/lalmaraz). Slides have been created and modified by [Thomas](https://github.com/mrpotatocode) in 2022, 2023, and 2024.
