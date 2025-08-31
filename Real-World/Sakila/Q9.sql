# Which customer has rented the most films?

with cte as(
select concat(first_name, ' ', last_name) as Customer_name, rental_id
from customer a
join rental b
on a.customer_id = b.customer_id
)

select Customer_Name, count(*) as No_of_Films_Rented
from cte
group by Customer_name
order by No_of_Films_Rented desc