# What’s the average amount spent by transaction type and account type?

# Average amount spent by Transaction Type
select TransactionType, round(avg(amount)) as Avg_Amount
from financeup
group by TransactionType
order by Avg_Amount desc; 

# Average amount spent by Account Type
select AccountType, round(avg(amount)) as Avg_Amount
from financeup
group by AccountType
order by Avg_Amount desc; 