# What time of day sees the highest average engagement? (Hint: Extract hour from PostDate)

with cte as (
select *, time(PostDate), time_format(PostDate, '%H') as TOD
from dataset
)

select TOD, round(avg(Likes + Shares + Comments), 2) as Avg_Engagement
from cte
group by TOD
order by Avg_Engagement desc