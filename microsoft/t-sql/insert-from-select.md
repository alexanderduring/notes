
INSERT from SELECT (T-SQL)
==========================

Problem: Your have a table EmailEvents with rows of different types (1, 2, 3) which represent different things that can be done with an email (sending, opening and clicking on links). The problem is, that the "Opened" events are missing for several emails and you want to add these. 

Given this table Test:

    Date_SID    Email_SID   Type
    ----------- ----------- -----------
    20160101    1           2           (Clicked)
    20160101    2           2
    20160102    2           2
    20160101    1           1           (Sent)
    20160101    2           1
    20151201    3           1
    20151201    3           2
    20151201    3           3           (Opened)

The rule would be: Every email that has at least one "Clicked" event should also have one "Opened" event and the date should be the same as the date of the first "Clicked" event.

The solution is..

    INSERT INTO [EmailEvents] (Date_SID, Email_SID, Type)
        SELECT
            Date_SID,
            Email_SID,
            3
        FROM (
            SELECT 
                e1.[Date_SID],
                e1.[Email_SID],
                ROW_NUMBER() OVER (PARTITION BY e1.[Email_SID] ORDER BY e1.[Date_SID]) AS number,
                e2.[SID] AS OpenEntrySID
            FROM 
                [EmailEvents] e1
            left JOIN
                [EmailEvents] e2 ON e2.Email_SID = e1.Email_SID and e2.Type = 3
            WHERE
                e1.Type = 2
        ) foo
        WHERE
            number = 1 and
            OpenEntrySID is null


which results in...

    Date_SID    Email_SID   Type
    ----------- ----------- -----------
    20160101    1           2
    20160101    2           2
    20160102    2           2
    20160101    1           1
    20160101    2           1
    20151201    3           1
    20151201    3           2
    20151201    3           3
    20160101    1           3
    20160101    2           3

