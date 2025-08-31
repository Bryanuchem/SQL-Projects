# Which account has the highest net savings (inflow - outflow)?

with cte as(
select AccountID,
round(sum(case when direction = 'Inflow' then amount end)) as Inflow,
round(sum(case when direction = 'Outflow' then amount end)) as Outflow
from financeup
group by AccountID
)

select Accountid, Outflow - Inflow as Net
from cte
order by Net desc