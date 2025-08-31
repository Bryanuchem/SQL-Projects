# Which 5 posts had the highest share-to-like ratio? (Use: Shares / Likes, avoid divide-by-zero)

with cte as (
    select PostID, Platform, Likes, Shares, Comments,
           round(case when Likes = 0 then 0 else Shares / Likes end, 2) as Share_Like_Ratio
    from dataset
)
select Platform, PostID, Share_Like_Ratio
from cte
order by Share_Like_Ratio desc
limit 5;