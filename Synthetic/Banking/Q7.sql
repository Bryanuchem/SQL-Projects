# Which category has the highest number of transactions?

select Category, count(*) as No_of_Transactions
from personalfinancedata
group by Category
order by No_of_Transactions desc
