CREATE DATABASE churn_analysis;

USE churn_analysis;

CREATE TABLE Churn_Modelling (
    RowNumber INT,
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15, 2),
    NumOfProducts INT,
    HasCrCard TINYINT,       
    IsActiveMember TINYINT,   
    EstimatedSalary DECIMAL(15, 2),
    Exited TINYINT            
);

SELECT 
    *
FROM
    churn_modelling
ORDER BY RowNumber;

SELECT 
    COUNT(*)
FROM
    churn_modelling;