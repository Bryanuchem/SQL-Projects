# How frequently does each customer shop (recency & frequency)?

with RF_Value as(
select CustomerID,
DATEDIFF(max(invoicedate), Min(invoicedate)) AS Recency,
COUNT(DISTINCT InvoiceNo) AS Frequency
from dataa
where customerid is not null
group by CustomerID
),

Recency_Scored AS (
    SELECT
        customerid,
        Recency,
        NTILE(5) OVER (ORDER BY Recency ASC) AS Recency_Score -- Corrected: Lower Recency (more recent) gets higher score
    FROM
        RF_Value
),
Frequency_Scored AS (
    SELECT
        customerid,
        Frequency,
        NTILE(5) OVER (ORDER BY Frequency) AS Frequency_Score
    FROM
        RF_Value
),
Combined_RFM_Scores AS (
    SELECT
        rs.customerid,
        rs.Recency_Score,
        fs.Frequency_Score
    FROM Recency_Scored rs
    JOIN Frequency_Scored fs 
    ON rs.customerid = fs.customerid
)

select * 
from Combined_RFM_Scores