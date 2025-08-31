# High-Risk Accounts: Which accounts have the most negative net flow?

select AccountID, round(sum(amount), 2) as Amountt
from personalfinancedata
group by AccountID
order by Amountt 