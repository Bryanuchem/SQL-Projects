WITH RFM_Values AS (
    SELECT
        c.customer_id,
         DATEDIFF(max(a.rental_date), Min(a.rental_date)) AS Recency, -- This calculates the span of orders, not true recency
       -- DATEDIFF(CURRENT_DATE(), MAX(a.order_date)) AS Recency, -- Calculate Recency from last order to today
        COUNT(DISTINCT a.rental_id) AS Frequency,
        SUM(amount) AS Monetary
        from rental a
			join payment b
			on a.customer_id = b.customer_id
			join rental c
			on b.rental_id = c.rental_id
			join inventory d
			on c.inventory_id = d.inventory_id
			join film e
			on e.film_id = d.film_id
			join customer f
			on b.customer_id = f.customer_id
            GROUP BY
        c.customer_id
),
Recency_Scored AS (
    SELECT
        customer_id,
        Recency,
        NTILE(5) OVER (ORDER BY Recency ASC) AS Recency_Score -- Corrected: Lower Recency (more recent) gets higher score
    FROM
        RFM_Values
),
Frequency_Scored AS (
    SELECT
        customer_id,
        Frequency,
        NTILE(5) OVER (ORDER BY Frequency) AS Frequency_Score
    FROM
        RFM_Values
),
Monetary_Scored AS (
    SELECT
        customer_id,
        Monetary,
        NTILE(5) OVER (ORDER BY Monetary) AS Monetary_Score
    FROM
        RFM_Values
),
Combined_RFM_Scores AS ( -- Renamed 'cte' for clarity
    SELECT
        rs.customer_id,
        rs.Recency_Score,
        fs.Frequency_Score,
        ms.Monetary_Score
    FROM
        Recency_Scored rs
    JOIN
        Frequency_Scored fs ON rs.customer_id = fs.customer_id
    JOIN
        Monetary_Scored ms ON rs.customer_id = ms.customer_id
),
Customer_RFM_Segments AS ( -- Renamed 'cte_2' for clarity
    SELECT
        c.customer_id, -- Keep customer_id for potential joins if needed later
        CONCAT(c.first_name, ' ', c.last_name) AS Customer_name,
        crs.Recency_Score,
        crs.Frequency_Score,
        crs.Monetary_Score,
        CONCAT(
            CAST(crs.Recency_Score AS CHAR),
            CAST(crs.Frequency_Score AS CHAR),
            CAST(crs.Monetary_Score AS CHAR)
        ) AS RFM_Score_String
    FROM Combined_RFM_Scores crs
    JOIN customer c ON crs.customer_id = c.customer_id
)
SELECT
    Customer_name,
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
        WHEN RFM_Score_String IN ('115', '114') THEN 'Lost High-Value'
        WHEN RFM_Score_String IN ('143', '133', '132') THEN 'Lapsed Frequent' -- NEW
        WHEN RFM_Score_String IN ('123') THEN 'Lost Potential' -- NEW
        WHEN RFM_Score_String IN ('111', '112', '121', '122', '113', '131', '141', '151') THEN 'Churned / Lost'
        ELSE 'Uncategorized'
    END AS Segment
FROM Customer_RFM_Segments
ORDER BY RFM_Score_String DESC;