# Monthly Net Worth Snapshot: For each account, calculate: Sum of inflows, Sum of outflows, Final balance after all transactions.

WITH cte AS (
    -- CTE to calculate Inflow and Outflow for each AccountID
    SELECT
        AccountID,
        ROUND(SUM(CASE WHEN Amount > 0 THEN Amount END), 2) AS Inflow,
        ROUND(SUM(CASE WHEN Amount < 0 THEN Amount END), 2) AS Outflow
    FROM personalfinancedata
    GROUP BY AccountID
),

cte_2 AS (
    -- CTE to find the BalanceAfter of the single last transaction for each AccountID
    -- ROW_NUMBER() assigns a rank based on date (descending) and transaction ID (descending)
    -- ensuring we pick the very last transaction.
    SELECT
        AccountID,
        BalanceAfter,
        ROW_NUMBER() OVER(PARTITION BY AccountID ORDER BY Date DESC, TransactionID DESC) as rn
    FROM personalfinancedata
)
-- Main query to combine the results from the two CTEs
SELECT
    a.AccountID,
    a.Inflow,
    a.Outflow,
    b.BalanceAfter AS FinalBalance
FROM cte a
JOIN cte_2 b 
ON a.AccountID = b.AccountID

WHERE b.rn = 1; -- Filter to get only the latest transaction's balance for each account