# What is the net balance change (total inflow − total outflow)? (Tip: inflow = amount > 0, outflow = amount < 0)

select AccountID, round(sum(case when Amount > 0 then amount end) - sum(case when Amount < 0 then amount end), 2) as Net_Balance_Change
from personalfinancedata
group by AccountID
order by Net_Balance_Change desc; 
