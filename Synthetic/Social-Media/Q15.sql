# Identify the most viral post: Highest combination of: High share-to-like ratio, High total engagement, Media included

# (Use: Shares / Likes, Likes + Shares + Comments, HasMedia)   
with cte as (
    select PostID, Platform, Likes, Shares, Comments, HasMedia,
           round(case when Likes = 0 then 0 else Shares / Likes end, 2) as Share_Like_Ratio,
           (Likes + Shares + Comments) as Total_Engagement
    from dataset
)
select PostID, Platform, HasMedia, Share_Like_Ratio, Total_Engagement
from cte
where HasMedia = '1'
order by Share_Like_Ratio desc, Total_Engagement desc
