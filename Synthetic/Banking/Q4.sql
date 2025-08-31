# What are the top 3 spending categories by total amount?

with cte as(
select *, abs(amount) as Amountt
from personalfinancedata
)

select Category, round(sum(Amountt), 2) as Total
from cte
group by category
order by Total desc
limit 3