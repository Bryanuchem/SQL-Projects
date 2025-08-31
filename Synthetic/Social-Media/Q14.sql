# Which day of the week has the highest average engagement? (Use: Likes + Shares + Comments, group by DAYNAME)

select DAYNAME(PostDate) as DayOfWeek, round(avg(Likes + Shares + Comments), 2) as AvgEngagement
from dataset
group by DayOfWeek
order by AvgEngagement desc;