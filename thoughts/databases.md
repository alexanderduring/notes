About adding new entries instead of updating existing entries
=============================================================

In some situations it is helpful to only add new entries to a table instead of updating existing entries. Take for example 
a table that contains information about business transactions with your customers.

| id |       date | customer_id | receivable | balance |
|---:|-----------:|------------:|-----------:|--------:|
|  1 | 2016-07-12 |          10 |      12.90 |   12.90 |

When the customer pays the money we could update the row and set the balance to 0.00:

| id |       date | customer_id | receivable | balance |
|---:|-----------:|------------:|-----------:|--------:|
|  1 | 2016-07-12 |          10 |      12.90 |    0.00 |

Instead I propose to save the data this way:

| id |       date | customer_id | receivable | balance |      row_created_at |
|---:|-----------:|------------:|-----------:|--------:|--------------------:|
|  1 | 2016-07-12 |          10 |      12.90 |   12.90 | 2016-07-12 15:04:30 |
|  2 | 2016-07-12 |          10 |       0.00 |  -12.90 | 2016-07-13 10:34:00 |

In order to get the same result as in the first table we have to do a select with "group by customer_id", 
sum(receivable) and sum(balance) but we get some big advantages with that:


