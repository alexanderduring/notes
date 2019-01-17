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

- First of all we get kind of a history of the transaction. By using the row_created_at date in the where clause we can not only determine the current state of the transaction, but the state for every point in the past since the transaction started.
- Second we can undo changes by going back to a point in the past by deleting all rows, that were created after that moment. This can be helpful, if you produce the rows with your own code and you want to fix a bug and recreate the rows from a certain date on.
- If this table is read periodically by a backup mechanism or a reporting tool, it does not need to read all rows every time. Because the rows are immutable, it only needs to read the new ones that were added since the last read out. This reduces data traffic a lot.
