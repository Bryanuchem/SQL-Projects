# Which customers have the highest total spend?

with cte as(
select CustomerID, round(Quantity * UnitPrice ,2) as Total_Spend
from dataa
)

select CustomerID, round(sum(Total_Spend), 2) as Total_Spend
from cte
where customerid is not null
group by CustomerID
order by Total_Spend desc
limit 10