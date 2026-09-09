-- 01_data_exploration.sql
-- Retail Sales SQL Project
-- Data Exploration


-- NOTE:
-- Query 1 creates the Retail_Sales database used for this project.
-- It is included to document the initial database setup.
-- Since the database already exists, this statement should not be
-- executed again unless the database is intentionally being recreated.


-- 1. Create database
CREATE DATABASE Retail_Sales;
GO


-- 2. Identify DBMS version
SELECT @@VERSION AS DBMS_Version;


-- 3. Identify current database
SELECT DB_NAME() AS current_database;


-- 4. List tables in the current database
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


-- 5. Inspect table columns and data types
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'retail_sales_dataset';


-- 6. Check for NULL values
SELECT
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Transaction_ID_NULLS,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_NULLS,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_NULLS,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_NULLS,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_NULLS,
    SUM(CASE WHEN Product_Category IS NULL THEN 1 ELSE 0 END) AS Product_Category_NULLS,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_NULLS,
    SUM(CASE WHEN Price_per_Unit IS NULL THEN 1 ELSE 0 END) AS Price_per_Unit_NULLS,
    SUM(CASE WHEN Total_Amount IS NULL THEN 1 ELSE 0 END) AS Total_Amount_NULLS
FROM retail_sales_dataset;

-- Observation(s):
-- No NULL values were identified across the dataset.
-- This indicates that the dataset does not contain missing values
-- in the fields examined.


-- Conclusion:
-- The dataset is complete with respect to NULL values, so no
-- missing-value treatment was required during the initial
-- exploration stage.


-- 7. Preview the first 10 records
SELECT TOP 10 *
FROM retail_sales_dataset
ORDER BY Customer_ID ASC;


-- 8. Check for duplicate Transaction_IDs
SELECT
    Transaction_ID,
    COUNT(*) AS total_transaction_ids
FROM retail_sales_dataset
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;


-- 9. Check for duplicate Customer_IDs
SELECT
    Customer_ID,
    COUNT(*) AS total_customer_ids
FROM retail_sales_dataset
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Observation:
-- No duplicate Transaction_IDs were identified.
--
-- According to the contextual overview in Kaggle(data-source)
-- the dataset used to conduct this project is purely synthetic.
-- Consequently, the Customer_IDs may only appear once in each transaction.


-- Conclusion:
-- Transaction_ID functions as a unique transaction identifier
-- within this dataset, while Customer_IDs are not unique at the
-- transaction level.


-- 10. Validate Gender categories
SELECT DISTINCT Gender
FROM retail_sales_dataset;


-- 11. Validate Product_Category categories
SELECT DISTINCT Product_Category
FROM retail_sales_dataset;

-- Observation:
-- Gender contains the expected categorical values.
-- Product_Category contains the product categories represented
-- in the dataset.


-- Conclusion:
-- The categorical fields appear suitable for segmentation and
-- comparison during the sales performance analysis.


-- 12. Check numerical ranges
SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    MIN(Quantity) AS min_quantity,
    MAX(Quantity) AS max_quantity,
    MIN(Price_per_Unit) AS min_price_per_unit,
    MAX(Price_per_Unit) AS max_price_per_unit,
    MIN(Total_Amount) AS min_total_amount,
    MAX(Total_Amount) AS max_total_amount
FROM retail_sales_dataset;

-- Observation:
-- The numerical fields contain values within plausible ranges
-- for the dataset, with no immediately obvious invalid values.


-- Conclusion:
-- No numerical values required correction during the initial
-- data validation stage.


-- 13. Validate Total_Amount against Quantity × Price_per_Unit
SELECT *
FROM retail_sales_dataset
WHERE Total_Amount <>
      CAST(Quantity AS INT) * Price_per_Unit;

-- Observation:
-- No records were returned where Total_Amount differed from
-- Quantity × Price_per_Unit.


-- Conclusion:
-- Total_Amount is internally consistent with Quantity and
-- Price_per_Unit across the dataset. The stored revenue values
-- can therefore be used confidently in subsequent analysis.
