/* Monthly Breakdown
Total spent and earned each month? */

select monthname(date) as Month,
round(sum(case when Direction = 'Inflow' then amount end)) as Inflow,
round(sum(case when Direction = 'Outflow' then amount end)) as Outflow
from financeup
group by Month