# Are there any geographical patterns in purchasing behavior?

select *
from dataa

;
with cte as(
select *, round(Quantity * UnitPrice ,2) as Total_Spend
from dataa
)

select Country, round(sum(Total_Spend), 2) as Total_Spend,
round(sum(UnitPrice),2) as Total_UnitPirce,
count(quantity) as Total_Quantity, 
round(avg(Total_Spend), 2) as Avg_Spend,
round(avg(UnitPrice),2) as Avg_UnitPirce
from cte
group by Country
order by Total_Spend desc
