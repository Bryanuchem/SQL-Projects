# Which platform shows the highest average share rate? (Use: Shares / (Likes + Comments) per post)

with cte as (
    select Platform, PostID, Likes, Shares, Comments,
           round(case when (Likes + Comments) = 0 then 0 else Shares / (Likes + Comments) end, 2) as Share_Rate
    from dataset
)
select Platform, round(avg(Share_Rate), 2) as Avg_Share_Rate
from cte
group by Platform
order by Avg_Share_Rate desc