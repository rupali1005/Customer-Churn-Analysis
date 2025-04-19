-- Intermediate Level Questions

#Top 5 high balance customers who churned.
SELECT 
    Surname, Geography, Age, Balance
FROM
    churn_modelling
WHERE
    exited = 1
ORDER BY balance DESC
LIMIT 5;

#Which customers have more than 2 products and are still active members?
SELECT 
    Surname AS Customers, NumOfProducts, IsActiveMember
FROM
    churn_modelling
WHERE
    NumOfProducts > 2 AND IsActiveMember = 1;

#What is the average balance of churned vs. retained customers?
SELECT 
    Exited, ROUND(AVG(Balance), 2) AS Average_Balance
FROM
    churn_modelling
GROUP BY Exited;

#Is there a pattern of churn based on age groups?
SELECT 
    CASE
        WHEN Age < 30 THEN 'Age Under 30'
        WHEN Age BETWEEN 30 AND 50 THEN 'AGE 30-50'
        WHEN Age > 50 THEN 'Age above 50'
    END AS Age_group,
    COUNT(*) AS Total_customers,
    SUM(EXITED) AS churned,
    ROUND(SUM(Exited) / COUNT(*) * 100, 2) AS churn_rate
FROM
    churn_modelling
GROUP BY Age_group;

#How does product holding affect churn?
SELECT 
    NumOfProducts,
    ROUND(SUM(CASE
                WHEN Exited = 1 THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS churn_rate_percnt
FROM
    churn_modelling
GROUP BY NumOfProducts
ORDER BY churn_rate_percnt DESC;

#Which customers have both a credit score above average and a balance above average?LIMIT 10
SELECT 
    CustomerId,
    Surname AS Customers,
    Gender,
    Age,
    CreditScore,
    Balance
FROM
    churn_modelling
WHERE
    CreditScore > (SELECT 
            AVG(CreditScore)
        FROM
            churn_modelling)
        AND Balance > (SELECT 
            AVG(Balance)
        FROM
            churn_modelling)
LIMIT 10;

#What is the churn rate for customers segmented by credit score range (e.g., 300–500, 501–700, 701–850)?
SELECT 
    CASE
        WHEN CreditScore BETWEEN 300 AND 500 THEN '300-500'
        WHEN CreditScore BETWEEN 501 AND 700 THEN '501-700'
        ELSE '701-850'
    END AS credit_score_range,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) / COUNT(*) * 100, 2) AS churn_rate
FROM
    churn_modelling
GROUP BY credit_score_range
ORDER BY churn_rate DESC;

#Customer Ranking based on their balance within each geography.
SELECT *
FROM (
    SELECT
       CustomerId,
        Surname AS Customers,
        EstimatedSalary,
        Geography,
        Balance,
        DENSE_RANK() OVER (PARTITION BY Geography ORDER BY Balance DESC) AS Ranks
    FROM churn_modelling
) AS ranked_customers
WHERE Ranks <= 5;

#Find the churn rate trend over tenure buckets (e.g., 0–2 years, 3–5 years, etc.).
SELECT 
    CASE
        WHEN Tenure BETWEEN 0 AND 2 THEN '0-2'
        WHEN Tenure BETWEEN 3 AND 5 THEN '3-5'
        WHEN Tenure BETWEEN 6 AND 8 THEN '6-8'
        ELSE '8-10'
    END AS Tenure_bucket,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) / COUNT(*) * 100, 2) AS churned_percent
FROM
    churn_modelling
GROUP BY Tenure_bucket;

#What are the combined customer behavior trends when considering credit score, credit card ownership, and activity level?
SELECT 
    HasCrCard,
    IsActiveMember,
    COUNT(*) AS customer_count,
    AVG(CreditScore) AS avg_creditscore,
    ROUND(SUM(CASE
                WHEN Exited = 1 THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS churn_rate_pct
FROM
    Churn_Modelling
GROUP BY HasCrCard , IsActiveMember;

	