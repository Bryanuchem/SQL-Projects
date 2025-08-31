/* Economic Factor Correlation
How do CPI, fuel prices, and unemployment rate relate to weekly sales trends? */
/*CPI*/
SELECT 
    ROUND(CPI, 1) AS CPI_Level,
    round(AVG(Weekly_Sales)) AS Avg_Sales
FROM sales
GROUP BY CPI_Level
ORDER BY CPI_Level;

/* Unemployment */
SELECT 
    ROUND(Unemployment, 1) AS Unemployment_Level,
    round(AVG(Weekly_Sales)) AS Avg_Sales
FROM sales
GROUP BY Unemployment_Level
ORDER BY Unemployment_Level;

/* Unemployment */
SELECT 
    ROUND(Fuel_price, 1) AS Fuel_Level,
    round(AVG(Weekly_Sales)) AS Avg_Sales
FROM sales
GROUP BY Fuel_Level
ORDER BY Fuel_Level;
