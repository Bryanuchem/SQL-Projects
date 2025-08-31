/*Seasonal Trends
How do monthly sales vary throughout the year across all stores? */
with cte as(
select *, monthname(date) as Month
from sales
)

select month, round(sum(weekly_sales)) as Total_Sales
from cte
group by month
order by Total_Sales