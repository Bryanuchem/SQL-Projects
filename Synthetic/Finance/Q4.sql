/* Account Type Comparison
What’s the average balance by account type? */

select AccountType, round(avg(BalanceAfter)) as Avg_Amount
from financeup
group by AccountType
order by Avg_Amount desc