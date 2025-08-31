# Which film category has generated the most revenue?

select e.Name, round(sum(amount)) as Revenue
from payment a
join rental b
on a.customer_id = b.customer_id
join inventory c
on c.inventory_id = b.inventory_id
join film_category d
on c.film_id = d.film_id
join category e
on d.category_id = e.category_id
group by e.name
order by Revenue desc