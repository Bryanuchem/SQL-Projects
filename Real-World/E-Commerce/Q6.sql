# What’s the average purchase interval for repeat customers?

SELECT
    customerid,
    round(AVG(DATEDIFF(next_purchase_date, invoicedate)),2) AS Average_Purchase_Interval_Days
FROM (
    SELECT
        customerid,
        invoicedate,
        LEAD(invoicedate, 1) OVER (PARTITION BY customerid ORDER BY invoicedate) AS next_purchase_date
    FROM
        data
) AS subquery
WHERE next_purchase_date IS NOT NULL
GROUP BY customerid
HAVING COUNT(invoicedate) > 1
order by Average_Purchase_Interval_Days desc;