-- Basic Level Questions

#What is the total number of customers in the dataset?
SELECT 
    COUNT(*) AS total_customers
FROM
    churn_modelling;

#How many customers are from each geography?
SELECT 
    geography, COUNT(*) AS total_customers
FROM
    churn_modelling
GROUP BY Geography;

#What is the average balance of customers by gender?
SELECT 
    gender, FLOOR(AVG(balance)) AS Average_balance
FROM
    churn_modelling
GROUP BY gender;

#What is the overall churn rate?
SELECT 
    ROUND(SUM(exited) / COUNT(*) * 100, 2) AS churn_percentage
FROM
    churn_modelling;

#Which geography has the highest churn rate?
SELECT 
    Geography,
    ROUND(SUM(exited) / COUNT(*) * 100, 2) AS churn_percentage
FROM
    churn_modelling
GROUP BY Geography
ORDER BY churn_percentage DESC;

#Find the percentage of churned customers by gender.
SELECT 
    gender,
    ROUND(SUM(exited) / COUNT(*) * 100, 2) AS churn_percentage
FROM
    churn_modelling
GROUP BY gender
ORDER BY churn_percentage DESC;

#Does customer tenure distribution vary by gender, and does one gender tend to stay with the company longer than the other?
SELECT 
    Gender,
    AVG(Tenure) AS Average_Tenure,
    COUNT(*) AS total_customers
FROM
    churn_modelling
GROUP BY gender;

#What is the churn rate among customers with credit cards?
SELECT 
    HasCrCard,
    ROUND(SUM(exited) / COUNT(*) * 100, 2) AS churn_percentage
FROM
    churn_modelling
GROUP BY HasCrCard
ORDER BY churn_percentage DESC;

#Do customers who hold a credit card have higher or lower credit scores on average?
SELECT 
    HasCrCard, AVG(CreditScore) AS Average_creditscore
FROM
    churn_modelling
GROUP BY HasCrCard;

#How does customer activity status (active vs inactive) correlate with credit score?
SELECT 
    IsActiveMember, AVG(CreditScore) AS Average_creditscore
FROM
    churn_modelling
GROUP BY IsActiveMember;

