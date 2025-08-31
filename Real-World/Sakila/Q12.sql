# What’s the total revenue generated per store?

select d.store_id, round(sum(amount)) as Revenue
from payment a
join rental b
on a.rental_id = b.rental_id
join inventory c
on b.inventory_id = c.inventory_id
join store d
on d.store_id = c.store_id
group by store_id
order by Revenue desc