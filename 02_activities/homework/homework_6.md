# Homework 6: Reflecton

- Due on Saturday, September 21 at 11:59pm
- Weight: 8% of total grade

<br>

**Write**: Reflect on your previous work and how you would adjust to include ethics and inequity components. Total length should be a few paragraphs, no more than one page.

#### Reflection

I have worked as a QA Engineer for a long time, so I will consider ethical aspects and inequality issues from the perspective of software testing. 

For the past 13 years, I have worked as a QA Engineer for American companies while being based in Europe, and since 2016, we were already required to comply with GDPR, but that was at my second job. At my first job, we developed an Application Lifecycle Management system (ALM), where we didn’t deal with personal data. However, we did implement features for people with visual impairments — we introduced a color scheme for colorblind users, although full WCAG standards support was not even considered at that time.

At my second job, we developed a product for companies providing electricity, gas, and water, and here we did work with user data. To test the system in conditions as close to real-world usage as possible, both in terms of load and distribution of electricity usage, we used real data, which was anonymized to prevent any customer information from being leaked. Additionally, our product underwent accessibility audits, so part of our responsibility was to conduct accessibility testing to ensure compliance with WCAG 2.0 standards.

When developing and testing a product for a broad audience, it’s essential to consider factors such as the user's computer literacy level, accessibility for people with limited financial or physical abilities, and eliminating discrimination based on gender, race, or other characteristics. This can be achieved by introducing variability in possible answers to seemingly straightforward questions. For example, for the question “Please select your age range,” you can provide the following answer options:
- <25
- 25-34 years
- 35-44 years
- 45-54 years
- 55-64 years
- 65 years
- Prefer not to say.

Or for the question: “Which option best describes your gender?” you can offer the following options:
- Woman
- Man
- Non-binary
- Prefer not to say
- Other
