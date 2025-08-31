# What is the total amount of money moved?

with cte as(
select *, abs(Amount) as Amountt
from personalfinancedata
)

select sum(amountt) as Total_Amount_Moved
from cte