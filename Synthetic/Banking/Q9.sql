# What is the daily net cash flow (total in − out per day)? (Show for each date — this helps see cash flow trends)

select Date, sum(amount) as Amount
from personalfinancedata
group by date
order by date;

#cSpell:disable
select Date, round(sum(case when amount > 0 then amount end) - sum(case when amount < 0 then amount end), 2) as Amount
from personalfinancedata
group by date
order by date;