# Detect potential late returners: list customers with the most delayed returns.

with cte as(
select concat(first_name, ' ', last_name) as Full_Name, 
a.customer_id, rental_duration, datediff(return_date ,rental_date) as Rental_Durationn
from rental a 
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
join customer d
on a.customer_id = d.customer_id
where return_date is not null
),

cte_2 as(
select *
from cte
where rental_duration < rental_durationn
)

select Full_Name, count(rental_durationn) as No_of_Late_Returns
from cte_2
group by Full_Name
order by No_of_Late_Returns desc
;

with cte as(
select concat(first_name, ' ', last_name) as Full_Name ,a.customer_id, rental_duration, datediff(return_date ,rental_date) as LateDays
from rental a 
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
join customer d
on a.customer_id = d.customer_id
)

select Full_Name, sum(LateDays) as Total_LateDays
from cte
group by Full_Name
order by Total_LateDays desc;