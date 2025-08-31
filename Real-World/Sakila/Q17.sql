#  Find customers who have rented from both stores.

with cte as(
select customer_id, count(distinct b.store_id) as Store
from rental a
join staff b
on a.staff_id = b.staff_id
join store c
on c.store_id = b.store_id
group by customer_id
)

select *
from cte
where Store > 1