# What percentage of posts include media (images/videos)? (Hint: Use HasMedia = 1 to filter)

select round((count(*)/500) * 100, 2) as Percentage_of_Posts_With_Media_Files
from dataset
where HasMedia = 1