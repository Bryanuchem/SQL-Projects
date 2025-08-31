# List the top 5 most rented films.

select b.film_id ,Title, count(*) as No_of_Times_Rented
from rental a 
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
group by film_id, title
order by No_of_Times_Rented desc