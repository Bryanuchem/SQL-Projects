# How many transactions were: Deposits, Withdrawals, Payments, Transfers, Salaries

select type, count(*) as NO_Of_Transactions
from personalfinancedata
group by type