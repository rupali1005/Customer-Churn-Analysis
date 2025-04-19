-- Advanced Level Questions

#customers who have above-average balance and below-average estimated salary.
WITH averages AS (
    SELECT 
        AVG(Balance) AS average_balance,
        AVG(EstimatedSalary) AS average_salary
    FROM churn_modelling
)
SELECT 
    CustomerId, Surname, Balance, EstimatedSalary
FROM 
    churn_modelling, averages
WHERE 
    Balance > averages.average_balance
    AND EstimatedSalary < averages.average_salary;


#Find the top 3 most loyal (longest-tenured) customers by age.
WITH age_grouped AS (
    SELECT *,
        CASE 
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age BETWEEN 30 AND 50 THEN '30-50'
            ELSE 'Above 50'
        END AS age_group
    FROM churn_modelling
),
ranked_customers AS (
    SELECT 
        CustomerID,
        Surname AS Customer,
        Age,
        Tenure,
        age_group,
        ROW_NUMBER() OVER (PARTITION BY age_group ORDER BY Tenure DESC) AS rank_by_tenure
    FROM age_grouped
)
SELECT *
FROM ranked_customers
WHERE rank_by_tenure <= 3;

#Compare churn rate between customers who have a balance vs. those who don't .
WITH balanced_group AS (
    SELECT 
        CustomerID,
        Balance,
        Exited,
        CASE 
            WHEN Balance = 0 THEN 'No Balance'
            ELSE 'Has Balance'
        END AS Balance_status
    FROM churn_modelling
)
SELECT 
    Balance_status, 
    COUNT(*) AS Customers,
    SUM(Exited) AS churned_customers,
    ROUND(SUM(Exited) / COUNT(*) * 100, 2) AS churn_rate
FROM balanced_group
GROUP BY Balance_status;
        