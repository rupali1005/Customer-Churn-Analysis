-- Data Cleaning

SELECT 
    *
FROM
    churn_modelling
WHERE
    RowNumber IS NULL OR CustomerId IS NULL
        OR Surname IS NULL
        OR CreditScore IS NULL
        OR Geography IS NULL
        OR Gender IS NULL
        OR Age IS NULL
        OR Tenure IS NULL
        OR Balance IS NULL
        OR NumOfProducts IS NULL
        OR HasCrCard IS NULL
        OR IsActiveMember IS NULL
        OR EstimatedSalary IS NULL
        OR Exited IS NULL;    
        
-- No NULL values in The Dataset.