/*  Daily Transaction Summary
How much money was moved per day? */

SELECT dayname(date) as Day, round(sum(Amount)) as Amount
FROM finance.financeup
group by Day
order by Amount