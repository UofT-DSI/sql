# SQL

## Content

* [Description](#description)
* [Learning Outcomes](#learning-outcomes)
* [Assignments](#assignments)
* [Contacts](#contacts)
* [Delivery of the Learning Module](#delivery-of-the-learning-module)
* [Schedule](#schedule)
* [Requirements](#requirements)
* [Resources](#resources)
  + [Documents](#documents)
  + [Videos](#videos)
* [Folder Structure](#folder-structure)

## Description

SQL is used across the machine learning pipeline, and is a fundamental skill for data scientists to master. This module will focus on the technical skills needed for working with SQL, including flat-file datasets (JSON, CSV) ingestion, query design, and relational database management. Additionally, participants will examine common data management concerns, data access management, and data privacy adherence.

Participants are introduced to data modelling and how to think about the structure of databases. The majority of the module is devoted to learning the necessary commands and their syntax to properly extract information from a database. Participants will learn how to problem-solve through live coding. 

## Learning Outcomes
By the end of the module, participants will be able to:

**Week 1:**
* Describe the structure of a database.
* Use an export command to save and transport data in CSV and JSON file formats.
* Use SQL querying and data manipulation techniques to formulate queries for a range of purposes.

**Week 2:**

* Examine the legal framework around sharing data.
* Analyze data requirements and work with diverse stakeholders such as analysts and managers.
* Use advanced techniques such as String Manipulation, and NULL Management to manipulate results.

## Assignments

Participants should review the [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md) for instructions on how to complete assignments in this module.

There are two assignments.

1. [Assignment 1](./02_activities/assignments/Assignment1.md)
1. [Assignment 2](./02_activities/assignments/Assignment2.md)

## Contacts

**Questions can be submitted to the #questions channel on Slack**

* Technical Facilitator:   
  * **Thomas Rosenthal** (he/him)  
    [thomas.rosenthal@utoronto.ca](mailto:thomas.rosenthal@utoronto.ca)

* Learning Support Staff: 
  * **James Li** (he/him)  
  [james.zefang.li@gmail.com](mailto:james.zefang.li@gmail.com)
  * **Laura MacKew** (she/her)  
  [lauramackew@gmail.com](mailto:lauramackew@gmail.com)
  * **Niyaz Nazari** (she/her)  
  [niyaz.mnazari@gmail.com](mailto:niyaz.mnazari@gmail.com)



## Delivery of the Learning Module

This module will include live learning sessions and optional, asynchronous work periods. During live learning sessions, the Technical Facilitator will introduce and explain key concepts and demonstrate core skills. Learning is facilitated during this time. Before and after each live learning session, the instructional team will be available for questions related to the core concepts of the module. Optional work periods are to be used to seek help from peers, the Learning Support team, and to work through the assignments in the learning module, with access to live help. Content is not facilitated, but rather this time should be driven by participants. We encourage participants to come to these work periods with questions and problems to work through. 
 
Participants are encouraged to engage actively during the learning module. They key to developing the core skills in each learning module is through practice. The more participants engage in coding along with the instructional team, and applying the skills in each module, the more likely it is that these skills will solidify. 

This module will use a dedicated _Etherboard_ for student collaboration. The link will be provided in the first class. New content will be added by the Technical Facilitator before each session. Each session will consist of slides to introduce topics, live coding to demonstrate the topics, and occasional breakout rooms/live polls to reinforce the topics.  

The technical facilitator will introduce the concepts through a collaborative live coding session using SQLite. The technical facilitator will upload any live coding files to this repository for participants to revisit under `./04_this_cohort/live_code`.

Participants should follow along with the coding, interact with the study material [SQL for Data Scientists by Renee Teate](https://sqlfordatascientists.com/), and think about the broader data landscape. Participants are encouraged to ask questions throughout. 

## Schedule 

Before First Live Learning Session: Install & Pre-Session [Setup](./05_src/sql/sqlite_setup/sqlite_setup.md)

||Day 1|Day 2|Day 3|Day 4|Day 5|
|---|---|---|---|---|---|
|Week 1|Live Learning Session 1 Introduction: Data Modelling, Schema Design, Data Structures |Live Learning Session 2 Building Queries: SELECT, FROM, WHERE, CASE, DISTINCT, JOINs|Live Learning Session 3 Essential Techniques: Aggregation Functions, Subqueries, Temporary Tables, CTEs, Datetime Functions |No Work Period|Work Period 2|

||Day 1|Day 2|Day 3|Day 4|Day 5|
|---|---|---|---|---|---|
|Week 2|Live Learning Session 4 Advanced Techniques: NULL Management, Windowed Functions, String Manipulation, UNION & UNION ALL, INTERSECT & EXCEPT  |Live Learning Session 5 Expanding your Database: INSERT, UPDATE, DELETE, Importing & Exporting Data, CROSS & Self Joins, Views   |Live Learning Session 6 Beyond SQL: Ethics and Case Study |Work Period 1|Work Period 2|

## Requirements

* Participants are not expected to have any coding experience; the learning content has been designed for beginners.
* Participants are encouraged to ask questions, and collaborate with others to enhance their learning experience.
* Participants must have a computer and an internet connection to participate in online activities.
* Participants must not use generative AI such as ChatGPT to generate code in order to complete assignments. It should be used as a supportive tool to seek out answers to questions you may have.
* We expect Participants to have completed the instructions mentioned in the [onboarding repo](https://github.com/UofT-DSI/onboarding/).
* We encourage participants to default to having their camera on at all times, and turning the camera off only as needed. This will greatly enhance the learning experience for all participants and provides real-time feedback for the instructional team. 

## Resources
Feel free to use the following as resources:

### Documents
- [Cheatsheet](https://www.sqlitetutorial.net/sqlite-cheat-sheet/)
- [W3Schools Tutorial](https://www.w3schools.blog/sqlite-tutorial)

### Videos
- [What is SQLite?](https://www.youtube.com/watch?v=p2tOmltUh34)
- [SQLite Playlist](https://www.youtube.com/playlist?list=PLWENznQwkAoxww-cDEfIJ-uuPDfFwbeiJ)

## Folder Structure

```markdown
.
├── .github
├── .gitignore
├── 01_materials
├── 02_activities
├── 03_instructional_team
├── 04_this_cohort
├── 05_src
├── LICENSE
└── README.md
```

* **.github**: Contains issue templates, pull request templates and workflows for the repository.
* **materials**: Module slides.
* **activities**: Contains self-assessments, graded assignments, and rubrics for evaluating assignments.
* **instructional_team**: Resources for the instructional team.
* **this_cohort**: Additional materials and resources for this cohort.
* **src**: Source code, databases, logs, and required dependencies (requirements.txt) needed during the module.
* **.gitignore**: Files to exclude from this folder, specified by the Technical Facilitator
* **LICENSE**: The license for this repository.
* **README**: This file.

