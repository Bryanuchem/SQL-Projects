WITH RFM_Values AS (
    SELECT
        customerid,
         DATEDIFF(max(invoicedate), Min(invoicedate)) AS Recency, -- This calculates the span of orders, not true recency
       -- DATEDIFF(CURRENT_DATE(), MAX(invoicedate)) AS Recency, -- Calculate Recency from last order to today
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(UnitPrice * quantity) AS Monetary
        from dataa
			 GROUP BY
        customerid
),
Recency_Scored AS (
    SELECT
        customerid,
        Recency,
        NTILE(5) OVER (ORDER BY Recency ASC) AS Recency_Score -- Corrected: Lower Recency (more recent) gets higher score
    FROM
        RFM_Values
),
Frequency_Scored AS (
    SELECT
        customerid,
        Frequency,
        NTILE(5) OVER (ORDER BY Frequency) AS Frequency_Score
    FROM
        RFM_Values
),
Monetary_Scored AS (
    SELECT
        customerid,
        Monetary,
        NTILE(5) OVER (ORDER BY Monetary) AS Monetary_Score
    FROM
        RFM_Values
),
Combined_RFM_Scores AS ( -- Renamed 'cte' for clarity
    SELECT
        rs.customerid,
        rs.Recency_Score,
        fs.Frequency_Score,
        ms.Monetary_Score
    FROM
        Recency_Scored rs
    JOIN
        Frequency_Scored fs ON rs.customerid = fs.customerid
    JOIN
        Monetary_Scored ms ON rs.customerid = ms.customerid
),
Customer_RFM_Segments AS ( -- Renamed 'cte_2' for clarity
    SELECT
        customerid, -- Keep customer_id for potential joins if needed later
        crs.Recency_Score,
        crs.Frequency_Score,
        crs.Monetary_Score,
        CONCAT(
            CAST(crs.Recency_Score AS CHAR),
            CAST(crs.Frequency_Score AS CHAR),
            CAST(crs.Monetary_Score AS CHAR)
        ) AS RFM_Score_String
    FROM Combined_RFM_Scores crs
    )
SELECT
    customerid,
    Recency_Score,
    Frequency_Score,
    Monetary_Score,
    RFM_Score_String,
    CASE
        WHEN RFM_Score_String = '555' THEN 'Champions'
        WHEN RFM_Score_String IN ('554', '545', '455') THEN 'Loyal Customers'
        WHEN RFM_Score_String IN ('544', '445', '454') THEN 'Loyal Customers / High-Value Loyal'
        WHEN RFM_Score_String IN ('553', '543', '535', '534', '453', '435', '355', '345') THEN 'Potential Loyalists / Promising'
        WHEN RFM_Score_String IN ('552', '551') THEN 'Loyal Engaged (Lower Value)'
        WHEN RFM_Score_String IN ('532') THEN 'Recent Engaged (Developing Value)' -- NEW
        WHEN RFM_Score_String IN ('444') THEN 'Solid Customers'
        WHEN RFM_Score_String IN ('442', '441') THEN 'Valuable but Declining Spend'
        WHEN RFM_Score_String IN ('432', '422', '421', '411') THEN 'Declining Engagement (Good Recency)' -- NEW
        WHEN RFM_Score_String IN ('511', '512', '521', '522') THEN 'New Customers'
        WHEN RFM_Score_String IN ('354', '344') THEN 'Steady Customers (Moderate Recency)' -- NEW
        WHEN RFM_Score_String IN ('443', '434', '343', '334', '533', '523', '433', '423') THEN 'Customers Needing Attention / Slipping'
        WHEN RFM_Score_String IN ('335') THEN 'Big Spenders (Lapsing Engagement)'
        WHEN RFM_Score_String IN ('333', '332') THEN 'Average Customers'
        WHEN RFM_Score_String IN ('323') THEN 'Irregular Spenders' -- NEW
        WHEN RFM_Score_String IN ('311', '312', '321', '322', '331', '233', '232', '223', '222') THEN 'At-Risk / Lapsing'
        WHEN RFM_Score_String IN ('254', '244', '243') THEN 'At-Risk Loyal / Valuable (Lapsing Recency)' -- NEW
        WHEN RFM_Score_String IN ('225', '224') THEN 'At-Risk High-Value'
        WHEN RFM_Score_String IN ('234') THEN 'At-Risk Regular' -- NEW
        WHEN RFM_Score_String IN ('221') THEN 'Almost Churned (Low Value)'
        WHEN RFM_Score_String IN ('212', '211') THEN 'Very At-Risk / Near Churn' -- NEW
        WHEN RFM_Score_String IN ('155', '154', '145', '144', '135', '134', '255', '245') THEN 'Cannot Lose Them / High-Value Lapsed'
        WHEN RFM_Score_String IN ('115', '114', '125') THEN 'Lost High-Value'
        WHEN RFM_Score_String IN ('143', '133', '132') THEN 'Lapsed Frequent' -- NEW
        WHEN RFM_Score_String IN ('123') THEN 'Lost Potential' -- NEW
        WHEN RFM_Score_String IN ('111', '112', '121', '122', '113', '131', '141', '151') THEN 'Churned'
        ELSE 'Uncategorized'
    END AS Segment
FROM Customer_RFM_Segments
ORDER BY RFM_Score_String DESC;