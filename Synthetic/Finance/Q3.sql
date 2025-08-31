/*  Deposits vs Withdrawals
What’s the total for deposits and withdrawals? */

select Direction, round(sum(Amount)) as Total
from financeup
group by Direction
order by Total desc
