
Last Email Sent Before Product Sale (T-SQL)
===========================================

Problem: Given two tables, one with product sales and the other one with sent emails. For every sold product We want to select the last email that was sent to the user before the sale took place.

Table Sales:

    Id   Sold_Date             User_Id
    ---- --------------------- -------
    1    2015-12-04 11:20:37   10
    2    2016-01-02 15:41:00   14
    3    2016-01-02 08:11:01   10


Table Emails:

    Id   Sent_Date             User_Id
    ---- --------------------- -------
    1    2015-12-01 12:00:00   10
    2    2015-12-01 12:00:00   14
    3    2016-01-01 12:00:00   10
    4    2016-01-01 12:00:00   14


First we create a joined table where every sale is paired with every email that was sent to the same user before the sale. We order the emails by sent date and add a row number with descending sent date:

    SELECT
        Sales.Id AS Sale_Id,
        Sales.Sold_Date,
        Emails.Id AS Email_Id,
        Emails.Sent_Date,
        ROW_NUMBER() OVER (PARTITION BY Sales.Id ORDER BY Emails.Sent_Date DESC) AS Row_Number
    FROM Sales
    LEFT JOIN Emails
    ON
        Emails.User_Id = Sales.User_Id AND
        Emails.Sent_Date < Sales.Sold_Date
    
    Sale_Id  Sold_Date            Email_Id  Sent_Date            Row_Number
    -------- -------------------- --------- -------------------- ----------
    1        2015-12-04 11:20:37  1         2015-12-01 12:00:00  1
    2        2016-01-02 15:41:00  4         2016-01-01 12:00:00  1
    2        2016-01-02 15:41:00  2         2015-12-01 12:00:00  2
    3        2016-01-02 08:11:01  3         2016-01-01 12:00:00  1
    3        2016-01-02 08:11:01  1         2015-12-01 12:00:00  2

Now we already have the information we want in this result table, but there are more rows than needed. We only need the rows where Row_Number = 1. But to filter for the row number we cannot use it in the WHERE clause. Instead we do it this way:

    SELECT
        Sale_Id,
        Sold_Date,
        Email_Id
        Sent_Date,
    FROM (
        SELECT
            Sales.Id AS Sale_Id,
            Sales.Sold_Date,
            Emails.Id AS Email_Id,
            Emails.Sent_Date,
            ROW_NUMBER() OVER (PARTITION BY Sales.Id ORDER BY Emails.Sent_Date DESC) AS Row_Number
        FROM Sales
        LEFT JOIN Emails
        ON
            Emails.User_Id = Sales.User_Id AND
            Emails.Sent_Date < Sales.Sold_Date
    ) S
    WHERE
        Row_Number = 1
    
    Sale_Id  Sold_Date            Email_Id  Sent_Date           
    -------- -------------------- --------- --------------------
    1        2015-12-04 11:20:37  1         2015-12-01 12:00:00
    2        2016-01-02 15:41:00  4         2016-01-01 12:00:00
    3        2016-01-02 08:11:01  3         2016-01-01 12:00:00

