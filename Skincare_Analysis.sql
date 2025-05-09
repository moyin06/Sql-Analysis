
																															--SKIN CARE ANALYSIS--

--1. Total sales, profit, and quantity sold?
SELECT SUM(Sales) Total_Sales, Floor(SUM(Profit))Total_Profit, SUM(Quantity) Total_Profit
FROM Skin_Care_Target;

--2. Average discount given?
SELECT Format(AVG(Discount), 'p') 
FROM Skin_Care_Target

--3. Overall profit margin
Select Round(SUM(Profit) / NULLIF(SUM(Sales), 0) *100, 2) AS Profit_Margin 
FROM skin_care_target;

-- 4. Year with highest total sales
SELECT Top 1 Year(Order_Date) AS [Year], SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY Year(Order_Date)
ORDER BY Total_Sales DESC;

-- 5. Monthly trend of sales
SELECT DATENAME(MONTH, [Order_Date]) AS Month_Name,
    MONTH([Order_Date]) AS Month_Number,
    SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY  DATENAME(MONTH, [Order_Date]), 
    MONTH([Order_Date])
ORDER BY 
    Month_Number;

-- 6. Monthly trend of profit
SELECT DATENAME(MONTH, [Order_Date]) AS Month_Name,
    MONTH([Order_Date]) AS Month_Number,
    SUM(Profit) AS [Total Profit]
FROM skin_care_target
GROUP BY  DATENAME(MONTH, [Order_Date]), 
    MONTH([Order_Date])
ORDER BY 
    Month_Number;

-- 7. Daily average sales
SELECT AVG(Sales) 
FROM skin_care_target;

-- 8. Day of week with highest average sales
SELECT TOP 1 DATENAME(Weekday, [Order_Date]) AS Month_Name, AVG(Sales) AS Average_Sales
FROM skin_care_target
GROUP BY DATENAME(Weekday, [Order_Date]);

-- 9. Top 10 best-selling products
SELECT  TOP 10 Product, SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY Product
ORDER BY Total_Sales DESC;


-- 10. Top 10 most profitable products
SELECT TOP 10  Product, Floor(SUM(Profit)) AS Total_Profit
FROM skin_care_target
GROUP BY Product
ORDER BY Total_Profit DESC;

-- 11. Subcategories with highest sales
SELECT TOP 5 Subcategory, SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY Subcategory
ORDER BY Total_Sales DESC;

-- 12. Subcategory with lowest average profit
SELECT TOP 1 Subcategory, AVG(Profit) AS Avg_Profit
FROM skin_care_target
GROUP BY Subcategory
ORDER BY Avg_Profit ASC


-- 13. Average discount per category
SELECT Category, AVG(Discount) AS Avg_Discount
FROM skin_care_target
GROUP BY Category;

-- 14. Subcategories with high sales but low profit

SELECT Subcategory, Max(Sales) AS Max_Sales, Min(Profit) AS Low_profit
FROM skin_care_target
GROUP BY Subcategory
ORDER BY Max_Sales DESC, Low_Profit DESC;

-- 15. Unique customers
SELECT COUNT(DISTINCT Customer_ID) 
FROM skin_care_target;

-- 16. Average purchase per customer
SELECT AVG(Customer_Sales) 
FROM(
  SELECT Customer_ID, SUM(Sales) AS Customer_Sales
  FROM skin_care_target
  GROUP BY Customer_ID
) AS sub;

-- 17. Segment by total profit
SELECT Segment, SUM(Profit) AS Total_Profit
FROM skin_care_target
GROUP BY Segment
ORDER BY Total_Profit DESC;

-- 18. Segment by average discount In %
SELECT Segment, Format(AVG(Discount), 'P') AS Avg_Discount
FROM skin_care_target
GROUP BY Segment;

-- 19. Countries by sales
SELECT Country, SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY Country
ORDER BY Total_Sales DESC;

-- 20. Regions with lowest avg profit
SELECT Region, AVG(Profit) AS Avg_Profit
FROM skin_care_target
GROUP BY Region
ORDER BY Avg_Profit ASC;

-- 21. City with most orders
SELECT TOP 1 City, COUNT(*) AS Order_Count
FROM skin_care_target
GROUP BY City
ORDER BY Order_Count DESC;

-- 22. Top 5 states by sales
SELECT TOP 5 [State], SUM(Sales) AS Total_Sales
FROM skin_care_target
GROUP BY State
ORDER BY Total_Sales DESC


-- 23. Avg quantity per country
SELECT Country, AVG(Quantity) AS Avg_Quantity
FROM skin_care_target
GROUP BY Country;

-- 24. Market with most profit
SELECT Market, SUM(Profit) AS Total_Profit
FROM skin_care_target
GROUP BY Market
ORDER BY Total_Profit DESC;

-- 25. Profit margin per market
WITH MarketSalesProfit AS (
  SELECT 
    Market, 
    SUM(Profit) AS Total_Profit, 
    SUM(Sales) AS Total_Sales
  FROM skin_care_target
  GROUP BY Market
)
SELECT 
  Market, 
  Total_Profit / NULLIF(Total_Sales, 0) AS Profit_Margin
FROM MarketSalesProfit;


-- 26. Sales-to-profit ratio per market
WITH MarketSalesProfit AS (
  SELECT 
    Market, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
  FROM skin_care_target
  GROUP BY Market
)
SELECT 
  Market, 
  Total_Sales / NULLIF(Total_Profit, 0) AS Sales_To_Profit
FROM MarketSalesProfit;


-- 27. Compare sales before/after discount
WITH DiscountStatus AS (
  SELECT 
    CASE 
      WHEN Discount = 0 THEN 'No Discount'
      ELSE 'With Discount'
    END AS Discount_Status,
    Sales
  FROM skin_care_target
)
SELECT 
  Discount_Status,
  COUNT(*) AS Order_Count,
  AVG(Sales) AS Avg_Sales
FROM DiscountStatus
GROUP BY Discount_Status;


-- 28. % of orders with a discount
WITH DiscountedOrders AS (
  SELECT 
    CASE 
      WHEN Discount > 0 THEN 1 
      ELSE 0 
    END AS Has_Discount
  FROM skin_care_target
)
SELECT 
  (SUM(Has_Discount) * 100.0) / COUNT(*) AS Percent_With_Discount
FROM DiscountedOrders;

-- 29. Best performing months across years
WITH MonthlySales AS (
  SELECT 
    DATENAME(MONTH, Order_Date) AS Month_Name,
    MONTH(Order_Date) AS Month_Number,
    Sales
  FROM skin_care_target
)
SELECT 
  Month_Name,
  Month_Number,
  SUM(Sales) AS Total_Sales
FROM MonthlySales
GROUP BY Month_Name, Month_Number
ORDER BY Total_Sales DESC;

