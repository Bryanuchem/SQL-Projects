# Which staff member has handled the most payments?

select d.staff_id, round(sum(amount)) as Revenue
from payment a
join rental b
on a.rental_id = b.rental_id
join inventory c
on b.inventory_id = c.inventory_id
join staff d
on a.staff_id = d.staff_id
group by staff_id
order by Revenue desc