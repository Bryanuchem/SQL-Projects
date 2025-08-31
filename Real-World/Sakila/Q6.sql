# How many stores are there, and where are they located?

select Store_id, City, Country
from store a
join address b
on a.address_id = b.address_id
join city c
on b.city_id = c.city_id
join country d
on c.country_id = d.country_id
