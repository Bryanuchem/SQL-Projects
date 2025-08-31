# Top Savers: Which 5 accounts have the highest average balance?

select AccountID, round(avg(BalanceAfter), 2) as BalanceAfter
from personalfinancedata
where AccountType = 'Savings'
group by AccountID
order by BalanceAfter desc
limit 5;


select AccountID, round(avg(BalanceAfter), 2) as BalanceAfter
from personalfinancedata
group by AccountID
order by BalanceAfter desc
limit 5;