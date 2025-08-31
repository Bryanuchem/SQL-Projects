# What is the total number of transactions per customer?

select CustomerID, count(*) as No_of_Transactions
from dataa
where CustomerID is not null
group by CustomerID
order by No_of_Transactions desc