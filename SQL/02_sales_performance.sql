-- 02_sales_performance.sql
-- Retail Sales SQL Project
-- Sales Performance Analysis
--
-- Dataset Context:
-- This analysis uses a synthetic retail sales dataset.
-- Therefore, all observations and conclusions are specific to
-- the values represented in this dataset and should not be
-- interpreted as real-world business findings.


-- 1. Overall sales performance
-- Measures the total number of transactions, total revenue,
-- average transaction value, minimum transaction value,
-- and maximum transaction value.

SELECT
    COUNT(*) AS total_transactions,
    SUM(Total_Amount) AS total_revenue,
    AVG(Total_Amount) AS average_transaction_value,
    MIN(Total_Amount) AS minimum_transaction_value,
    MAX(Total_Amount) AS maximum_transaction_value
FROM retail_sales_dataset;


-- Observation:
-- The dataset contains 1,000 transactions with total revenue
-- of approximately 456,000.
-- The average transaction value is approximately 456,
-- while transaction values range from 25 to 2,000.


-- Conclusion:
-- The synthetic dataset contains a wide range of transaction
-- values, providing sufficient variation for basic sales
-- performance analysis.


-- 2. Revenue by product category
-- Determines which product categories generate the most revenue.

SELECT
    Product_Category,
    SUM(Total_Amount) AS total_revenue
FROM retail_sales_dataset
GROUP BY Product_Category
ORDER BY total_revenue DESC;


-- Observation:
-- Electronics generates the highest total revenue among the
-- product categories represented in the dataset.


-- Conclusion:
-- Within this synthetic dataset, Electronics is the strongest
-- product category in terms of total revenue.


-- 3. Compare sales performance across product categories
-- Compares transaction volume, quantity sold, revenue,
-- and average transaction value.

SELECT
    Product_Category,
    COUNT(*) AS total_transactions,
    SUM(CAST(Quantity AS INT)) AS total_quantity_sold,
    SUM(Total_Amount) AS total_revenue,
    AVG(Total_Amount) AS average_transaction_value
FROM retail_sales_dataset
GROUP BY Product_Category
ORDER BY total_revenue DESC;


-- Observation:
-- Clothing records the highest quantity of units sold, while
-- Electronics generates the highest total revenue and has the
-- highest average transaction value.


-- Conclusion:
-- The category with the highest unit volume is not necessarily
-- the category generating the highest revenue. In this dataset,
-- Electronics generates more revenue despite Clothing selling
-- more units.


-- 4. Average price per unit by product category
-- Compares the average unit price between product categories.

SELECT
    Product_Category,
    AVG(Price_per_Unit) AS average_price_per_unit
FROM retail_sales_dataset
GROUP BY Product_Category
ORDER BY average_price_per_unit DESC;


-- Observation:
-- Electronics has a higher average price per unit than Clothing.


-- Conclusion:
-- The higher average unit price of Electronics helps explain
-- why it generates more revenue despite Clothing selling more
-- units.


-- 5. Revenue generated per unit by product category
-- Compares total revenue relative to the number of units sold.

SELECT
    Product_Category,
    SUM(Total_Amount) AS total_revenue,
    SUM(CAST(Quantity AS INT)) AS total_quantity_sold,
    SUM(Total_Amount) / SUM(CAST(Quantity AS INT)) AS revenue_per_unit
FROM retail_sales_dataset
GROUP BY Product_Category
ORDER BY revenue_per_unit DESC;


-- Observation:
-- Electronics generates more revenue per unit than Clothing.


-- Conclusion:
-- The synthetic dataset shows that revenue performance is
-- influenced not only by the number of units sold, but also
-- by the value associated with each unit.


-- 6. Identify transactions above the overall average transaction value
-- Determines how many transactions have a value greater
-- than the overall average.

SELECT
    COUNT(*) AS transactions_above_average
FROM retail_sales_dataset
WHERE Total_Amount >
      (
          SELECT AVG(Total_Amount)
          FROM retail_sales_dataset
      );


-- Observation:
-- 350 of the 1,000 transactions have a transaction value
-- greater than the overall average.


-- Conclusion:
-- Only 35% of transactions in this synthetic dataset exceed
-- the overall average transaction value.


-- 7. Calculate the percentage of transactions above the average
-- Places the number of above-average transactions in context
-- relative to all transactions.

SELECT
    COUNT(*) AS transactions_above_average,
    COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM retail_sales_dataset)
        AS percentage_of_transactions
FROM retail_sales_dataset
WHERE Total_Amount >
      (
          SELECT AVG(Total_Amount)
          FROM retail_sales_dataset
      );


-- Observation:
-- Transactions above the overall average account for 35% of
-- all transactions.


-- Conclusion:
-- The majority of transactions in the synthetic dataset fall
-- at or below the overall average transaction value.


-- 8. Calculate revenue generated by above-average transactions
-- Measures how much of total revenue comes from transactions
-- whose value exceeds the overall average.

SELECT
    SUM(Total_Amount) AS revenue_from_above_average_transactions,
    SUM(Total_Amount) * 100.0 /
        (SELECT SUM(Total_Amount) FROM retail_sales_dataset)
        AS percentage_of_total_revenue
FROM retail_sales_dataset
WHERE Total_Amount >
      (
          SELECT AVG(Total_Amount)
          FROM retail_sales_dataset
      );


-- Observation:
-- The 35% of transactions above the overall average generate
-- approximately 85.3% of total revenue.


-- Conclusion:
-- Revenue is highly concentrated among the higher-value
-- transactions within this synthetic dataset.


-- 9. Combine transaction and revenue concentration
-- Summarizes the proportion of transactions above the overall
-- average and the proportion of total revenue they generate.

SELECT
    COUNT(*) AS transactions_above_average,
    COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM retail_sales_dataset)
        AS percentage_of_transactions,
    SUM(Total_Amount) AS revenue_generated,
    SUM(Total_Amount) * 100.0 /
        (SELECT SUM(Total_Amount) FROM retail_sales_dataset)
        AS percentage_of_total_revenue
FROM retail_sales_dataset
WHERE Total_Amount >
      (
          SELECT AVG(Total_Amount)
          FROM retail_sales_dataset
      );


-- Final Observation:
-- A relatively small proportion of transactions accounts for
-- a disproportionately large proportion of total revenue.


-- Final Conclusion:
-- The sales analysis shows meaningful differences between
-- product categories and transaction values within the
-- synthetic dataset. Electronics generates the most revenue
-- despite Clothing recording a higher unit volume, while
-- above-average transactions contribute a disproportionately
-- large share of total revenue.

