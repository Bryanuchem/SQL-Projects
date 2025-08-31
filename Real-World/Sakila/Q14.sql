# How many customers have never rented anything?

select (599 -  count(distinct b.customer_id)) as No_of_Customer_With_No_Purchase
from customer a
join rental b
on a.customer_id = b.customer_id