/* Spending by Category
What’s the total and average amount spent in each category? */

select Category, round(avg(amount)) as Avg_Amount, round(sum(amount)) as Total_Amount
from financeup
group by Category
order by Total_Amount desc