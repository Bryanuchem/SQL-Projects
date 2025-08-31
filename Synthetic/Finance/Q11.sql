# Which day of the week sees the most transactions?
 
 select dayname(Date) as Day, count(*) as No_of_Transactions
 from financeup
 group by Day