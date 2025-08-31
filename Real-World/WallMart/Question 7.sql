/* Anomaly Detection
Identify the top 5 weeks with unusually high or low sales for each store. */
/* Highest Sales*/
SELECT Store, Date, Weekly_Sales
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY Store ORDER BY Weekly_Sales DESC) AS rank_high
    FROM sales
) AS ranked
WHERE rank_high <= 5
ORDER BY Store, Weekly_Sales DESC;

/*lowest Sales*/
SELECT Store, Date, Weekly_Sales
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY Store ORDER BY Weekly_Sales ASC) AS rank_low
    FROM sales
) AS ranked
WHERE rank_low <= 5
ORDER BY Store, Weekly_Sales ASC;
