# Do posts with media perform better on average?
# Compare average engagement for: HasMedia = 1, HasMedia = 0

select 
round(avg(case when Hasmedia = 0 then Likes + Shares + Comments end)) as No_Media,
round(avg(case when Hasmedia = 1 then Likes + Shares + Comments end)) as Has_Media
from dataset