# Category Behavior by Account Type: Which spending categories are most common in Credit accounts?

select Category, Count(Category) as Count_No
from personalfinancedata
where AccountType = 'Credit'
group by Category
order by Count_No desc