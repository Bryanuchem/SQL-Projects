# Which day of the week has the highest rental volume?

select dayname(rental_date) as DOTW, count(*) as Rental_Count
from rental
group by DOTW 
order by Rental_Count desc