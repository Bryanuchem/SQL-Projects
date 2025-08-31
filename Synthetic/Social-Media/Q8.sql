# Which platform has the highest average engagement per post?


select Platform, round(avg(Likes + Shares + Comments), 2) as Avg_Engagment
from dataset
group by Platform
order by Avg_Engagment desc