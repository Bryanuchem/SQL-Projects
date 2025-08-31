/*Holiday Impact
What is the difference in average sales during holiday weeks vs non-holiday weeks? */
select holiday_flag, round(avg(weekly_sales)) as Avg_Weekly_Sales
from sales
group by holiday_flag