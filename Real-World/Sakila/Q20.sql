# Is there a relationship between film length and rental frequency?

select 
case when length between 45 and 70 then '45mins - 70mins'
when length between 70 and 100 then '70mins - 100mins'
when length between 100 and 140 then '100mins - 140mins'
when length > 140 then '140mins - 190mins'
end as Length_Group, count(rental_id) as Total_Rentals
from film a
join inventory b
on a.film_id = b.film_id
join rental c
on b.inventory_id = c.inventory_id
group by 1
order by Total_Rentals desc