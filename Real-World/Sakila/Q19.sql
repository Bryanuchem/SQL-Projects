# Which film has the highest average revenue per rental?

select title, round(avg(amount), 2) as Avg_Revenue
from rental a 
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
join payment d
on a.rental_id = d.rental_id
group by title
order by Avg_Revenue desc