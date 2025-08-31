# Which account had the largest single transaction, and what was it?

with cte as(
select *, abs(Amount) as Amountt
from personalfinancedata
)

select max(amountt) as Amounttt
from cte;