# Which post had the highest engagement overall? (Use: Likes + Shares + Comments as total engagement)

select PostID, Platform, (likes + Shares + Comments) as Total_Engagement
from dataset
order by Total_Engagement desc