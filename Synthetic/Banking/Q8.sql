# What is the average transaction amount per category?

with cte as(
select *, abs(amount) as Amountt
from personalfinancedata
)

select Category, round(avg(Amountt), 2) as Avg_Amount
from cte
group by Category 
order by Avg_Amount desc