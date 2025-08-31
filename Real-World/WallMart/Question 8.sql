/* Growth Over Time
Which stores show consistent quarter-over-quarter growth?*/

WITH QuarterlySales AS (
    SELECT 
        Store,
        QUARTER(Date) AS Quarter,
        YEAR(Date) AS Year,
        round(SUM(Weekly_Sales)) AS Total_Quarter_Sales
    FROM sales
    GROUP BY Store, YEAR(Date), QUARTER(Date)
),
WithGrowth AS (
    SELECT *,
           LAG(Total_Quarter_Sales) OVER (PARTITION BY Store ORDER BY Year, Quarter) AS Prev_Quarter_Sales,
           (Total_Quarter_Sales - LAG(Total_Quarter_Sales) OVER (PARTITION BY Store ORDER BY Year, Quarter)) AS Growth
    FROM QuarterlySales
)
SELECT * FROM WithGrowth
WHERE Growth > 0;
