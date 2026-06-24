# Connect-Wave-Telecom
📡 Connect Wave Telecom Customer Churn Analysis
Project Overview
Connect Wave Telecom is a rapidly growing telecommunications company operating across Nigeria, offering mobile voice, data, home internet, and enterprise connectivity services. Despite strong customer acquisition, the company experienced a significant increase in customer churn, resulting in declining customer retention, reduced recurring revenue, and growing customer dissatisfaction.
This project was conducted to identify the key drivers of customer churn and provide actionable recommendations that would help the company improve customer retention, increase customer satisfaction, and protect long-term revenue.
________________________________________
Business Problem
Connect Wave reported a customer churn rate of 50.2%, significantly higher than the telecom industry benchmark of 20–30%. The company lacked visibility into why customers were leaving and how operational issues such as billing delays, network outages, and customer support experiences were impacting retention.
Key Business Questions
•	Which customer segments are most likely to churn?
•	Which service plans experience the highest churn rates?
•	How do billing delays affect customer retention?
•	Does customer support performance influence churn?
•	Do network outages contribute to customer loss?
•	Which regions generate the highest revenue and revenue loss?
________________________________________
Dataset Overview
The project utilized a multi-table telecom dataset designed to simulate a real-world enterprise environment.
Tables Used
•	Customer Information
•	Usage Records
•	Billing Transactions
•	Support Tickets
•	Network Outage Logs
Data Quality Challenges
The dataset intentionally contained several real-world data issues:
•	Missing values
•	Duplicate records
•	Invalid age values
•	Inconsistent state names
•	Mixed billing formats
•	Null contract information
•	Category inconsistencies
•	Negative usage values
•	Extreme outliers
These challenges provided an opportunity to demonstrate practical data cleaning and quality assurance techniques.
________________________________________
SQL Data Cleaning & Preparation
Before analysis, I performed extensive data cleaning was performed using SQL.
Key data cleaning techniques I carried out include:
I identified and treated missing values across demographic, billing, and support-related fields.
I removed duplicate customer records using window functions and row numbering techniques.
I standardized:
•	State names
•	Support ticket categories
•	Payment methods
•	Contract types
I corrected:
•	Invalid age values
•	Negative usage values
•	Incorrect billing records
Standardized currency formats such as:
•	₦15,000
•	NGN15000
•	15,000
, and converted them into consistent numeric values for analysis.
I identified and evaluated unrealistic usage patterns and billing anomalies to improve analytical accuracy.
________________________________________
Exploratory Data Analysis (EDA)
I carried out exploratory analysis to uncover patterns, trends, and relationships affecting customer retention.
Areas Explored
Customer Analysis
•	Customer demographics
•	Age groups
•	Gender distribution
•	Geographic segmentation
Revenue Analysis
•	Monthly recurring revenue
•	Revenue by region
•	Revenue by service plan
•	Revenue lost to churn
Churn Analysis
•	Churn by contract type
•	Churn by tenure
•	Churn by payment method
•	Churn by customer segment
Customer Support Analysis
•	Complaint categories
•	Resolution times
•	Customer satisfaction trends
•	Support ticket volume
Network Performance Analysis
•	Outage frequency
•	Outage duration
•	Regional outage distribution
•	Outage impact on churn
________________________________________
Data Modeling
I developed a star schema model in Power BI to support scalable reporting and performance optimization.
Dimension Tables
•	Customer Dimension
•	Date Dimension
•	Region Dimension
Fact Tables
•	Usage Fact
•	Billing Fact
•	Support Ticket Fact
•	Network Outage Fact
This structure enabled efficient KPI calculations, cross-filtering, and dashboard interactivity.
________________________________________
Power BI Dashboard
The final dashboard was divided into five analytical areas:
Executive Overview
•	Total Customers
•	Active Customers
•	Churn Rate
•	Monthly Revenue
•	Revenue Lost to Churn
Customer Analysis
•	Churn by Age Group
•	Churn by Gender
•	Churn by State
•	Customer Segmentation
Revenue Analysis
•	Revenue by Plan
•	Revenue by State
•	Revenue Lost to Churn
•	Customer Lifetime Value (CLV)
Churn Drivers
•	Churn by Contract Type
•	Churn by Tenure
•	Churn by Billing Delays
•	Support Tickets vs Churn
Network & Support Performance
•	Outages by Region
•	Outage Duration
•	Revenue Impact of Outages
•	Resolution Time Analysis
•	Satisfaction Analysis
________________________________________
Key Insights
Customer Churn
•	The company recorded a churn rate of 50.2%, indicating a severe customer retention challenge.
•	Customers aged 26–35 years had the highest churn rates.
•	Gender showed little influence on churn behavior.
•	Abuja recorded the highest churn rate, while Lagos generated the highest churn volume due to its larger customer base.
________________________________________
Revenue Performance
•	Monthly recurring revenue exceeded ₦896 million.
•	Approximately ₦2.28 billion in revenue was lost due to customer churn.
•	Enterprise customers generated the highest revenue and customer lifetime value.
•	Lagos and Abuja were the company's most valuable revenue-generating regions.
________________________________________
Churn Drivers
Billing Delays
One of the strongest predictors of churn.
•	Churned customers experienced an average billing delay of 17 days.
•	Retained customers averaged only 3.5 days.
Support Tickets
Customer complaints strongly influenced churn behavior.
•	Customers with more than eight support tickets experienced churn rates exceeding 85%.
•	Frequent complaints indicated unresolved service issues and declining customer satisfaction.
Service Plans
•	Basic plan customers experienced the highest churn rate (72.8%).
•	Enterprise customers showed the strongest retention rates.
________________________________________
Network Performance
Outages vs Churn
Network reliability was a major churn driver.
•	Churned customers experienced an average of 5.5 outages.
•	Retained customers experienced approximately 1.5 outages.
Outage Duration
•	Average outage duration was 4.3 hours, exceeding company service targets.
•	Outages impacted approximately ₦299 million in revenue.
________________________________________
Customer Satisfaction
Customer satisfaction emerged as the strongest predictor of retention.
•	Retained customers averaged a satisfaction score of 4.45/5.
•	Churned customers averaged only 1.75/5.
Customers reporting the lowest satisfaction scores exhibited churn rates approaching 90%, highlighting the direct relationship between customer experience and retention.
________________________________________
Business Recommendations
Based on my findings, I recommended four strategic initiatives:
1. Improve Network Reliability
•	Reduce outage frequency
•	Shorten outage duration
•	Increase infrastructure investment in high-risk regions
2. Optimize Billing Processes
•	Automate payment reminders
•	Improve billing transparency
•	Resolve billing disputes faster
3. Enhance Customer Support
•	Reduce ticket resolution times
•	Improve complaint escalation processes
•	Proactively engage high-risk customers
4. Strengthen Retention Programs
•	Introduce loyalty rewards
•	Create personalized offers
•	Target high-value customers with retention campaigns
________________________________________
Tools & Technologies
•	SQL Server
•	Power BI
•	DAX
•	Excel
•	Data Modeling
•	Data Cleaning
•	Exploratory Data Analysis (EDA)
________________________________________
Skills Demonstrated
•	Data Cleaning & Transformation
•	SQL Querying
•	Data Quality Assessment
•	Exploratory Data Analysis
•	Data Modeling
•	KPI Development
•	DAX Calculations
•	Dashboard Design
•	Business Intelligence
•	Root Cause Analysis
•	Data Storytelling
•	Strategic Recommendation Development
________________________________________
Project Outcome
This project, I transformed raw telecom data into actionable business insights, enabling Connect Wave Telecom to identify the root causes of customer churn and develop targeted retention strategies. The analysis I carried out revealed that billing delays, network outages, poor customer support experiences, and low satisfaction scores were the primary drivers of customer attrition. By addressing these areas, the company can significantly improve customer retention, protect recurring revenue, and support long-term business growth.


