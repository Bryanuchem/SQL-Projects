/* Top 5 Highest Transactions
Which transactions involved the most money? */

SELECT TransactionID, round(amount) as Amount
FROM finance.finance
order by amount desc
limit 5