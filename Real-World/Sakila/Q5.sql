# Which actor has appeared in the most films?
with cte as(
select film_id, concat(first_name, ' ', last_name) as Actor_Name
from film_actor a 
join actor b
on a.actor_id = b.actor_id)

select Actor_Name, count(film_id) as No_of_Films
from cte
group by Actor_Name
order by No_of_Films desc
Limit 1