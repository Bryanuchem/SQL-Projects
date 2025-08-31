# Which platform has the most posts?

select Platform, count(*) as No_of_Posts
from dataset
group by Platform 
order by No_of_Posts desc