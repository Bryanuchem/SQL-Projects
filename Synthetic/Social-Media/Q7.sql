# Who are the top 3 most engaging users on average? (Average engagement per post = (Likes + Shares + Comments)/Posts)

select UserID, round(avg(Likes + Shares + Comments), 2) as Avg_Engagment
from dataset
group by Userid
order by Avg_Engagment desc
limit 3;

select UserID, round(sum(Likes + Shares + Comments) /count(*),2) as Avg_Engagment
from dataset
group by Userid
order by Avg_Engagment desc
limit 3;