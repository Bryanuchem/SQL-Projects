# Which account type has the highest average balance?

select AccountType, round(avg(BalanceAfter), 2) as BalanceAfter
from personalfinancedata
group by AccountType
order by BalanceAfter desc