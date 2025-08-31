/*  Net Flow per Account
For each AccountID, calculate total inflow and outflow. */

select AccountID, 
round(sum(case when Direction = 'Inflow' then amount end)) as Inflow,
round(sum(case when Direction = 'Outflow' then amount end)) as Outflow
from financeup
group by  Accountid