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


-- 10. Validate Gender categories
SELECT DISTINCT Gender
FROM retail_sales_dataset;


-- 11. Validate Product_Category categories
SELECT DISTINCT Product_Category
FROM retail_sales_dataset;


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


-- 13. Validate Total_Amount against Quantity × Price_per_Unit
SELECT *
FROM retail_sales_dataset
WHERE Total_Amount <>
      CAST(Quantity AS INT) * Price_per_Unit;
