# What is the average number of likes, shares, and comments?

select round(avg(likes), 2) as Avg_Likes, round(avg(Shares), 2) as Avg_Shares, round(avg(Comments), 2) as Avg_Comments 
from dataset