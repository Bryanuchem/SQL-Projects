# Which category contributes the most to outflows?

select Category, round(sum(amount)) as Amount
from financeup
where Direction = 'Outflow'
group by Category
order by Amount desc
