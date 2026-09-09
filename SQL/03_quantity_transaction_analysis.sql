USE Retail_Sales;
GO

-- 10. Average Transaction Value by Quantity Purchased

SELECT
    Quantity,
    AVG(Total_Amount) AS Avg_Transaction_Value
FROM dbo.retail_sales_dataset
GROUP BY Quantity
ORDER BY Quantity DESC;

-- Conclusion:

-- The results show that average transaction value increases as the quantity purchased increases. 
-- However, this relationship should be interpreted cautiously, as the transaction value may be mechanically influenced by the quantity purchased. 
-- Therefore, the result demonstrates a pattern within the dataset but does not necessarily represent an independent business insight.

