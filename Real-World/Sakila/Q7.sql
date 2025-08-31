# Which city has the highest number of customers?
select city, count(a.customer_id) as Customers
from customer a
join address b
on a.address_id = b.address_id
join city c
on b.city_id = c.city_id
join rental d
on a.customer_id = d.rental_id
group by city
order by Customers desc
limit 5