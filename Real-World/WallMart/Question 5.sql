/*Store-Level Seasonality
What are the busiest months for each individual store? */
with cte as(
select *, monthname(date) as Month
from sales
),
cte_2 as(
select store,
round(sum(case when Month = 'January' then Weekly_sales end)) as January,
round(sum(case when Month = 'February' then Weekly_sales end)) as February,
round(sum(case when Month = 'March' then Weekly_sales end)) as March,
round(sum(case when Month = 'April' then Weekly_sales end)) as April,
round(sum(case when Month = 'May' then Weekly_sales end)) as May,
round(sum(case when Month = 'June' then Weekly_sales end)) as June,
round(sum(case when Month = 'July' then Weekly_sales end)) as July,
round(sum(case when Month = 'August' then Weekly_sales end)) as August,
round(sum(case when Month = 'September' then Weekly_sales end)) as September,
round(sum(case when Month = 'October' then Weekly_sales end)) as October,
round(sum(case when Month = 'November' then Weekly_sales end)) as November,
round(sum(case when Month = 'December' then Weekly_sales end)) as December
from cte
group by store
)
SELECT
    Store,
    GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) AS HighestSalesValue,
    CASE
        WHEN January = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'January'
        WHEN February = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'February'
        WHEN March = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'March'
        WHEN April = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'April'
        WHEN May = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'May'
        WHEN June = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'June'
        WHEN July = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'July'
        WHEN August = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'August'
        WHEN September = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'September'
        WHEN October = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'October'
        WHEN November = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'November'
        WHEN December = GREATEST(January, February, March, April, May, June, July, August, September, October, November, December) THEN 'December'
        ELSE 'N/A' -- In case no match (shouldn't happen with valid data)
    END AS HighestSalesMonth
FROM
    cte_2;