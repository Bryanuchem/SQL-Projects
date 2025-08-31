/*Best and Worst Performing Stores
Which store had the highest and lowest average weekly sales?*/
select store, round(avg(weekly_sales)) as Avg_Weekly_Sales
from sales
group by store
order by Avg_Weekly_Sales desc
limit 1;

select store, round(avg(weekly_sales)) as Avg_Weekly_Sales
from sales
group by store
order by Avg_Weekly_Sales asc
limit 1;