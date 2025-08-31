# Which film has the longest runtime?

select Title, max(length) as Length
from film
group by title
order by Length desc
limit 1