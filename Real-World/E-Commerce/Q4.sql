# What is the average order value per customer?

with cte as(
select CustomerID, round(Quantity * UnitPrice ,2) as Total_Spend
from dataa
)

select CustomerID, round(avg(Total_Spend), 2) as Avg_Spend
from cte
where customerid is not null
group by CustomerID
order by Avg_Spend desc
limit 10