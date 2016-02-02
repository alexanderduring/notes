
INSERT from SELECT (T-SQL)
==========================

Problem: Your have a table EmailEvents with rows of different types (1, 2, 3) which represent different things that can be done with an email (sending, opening and clicking on links). The problem is, that the "Opened" events are missing for several emails and you want to add these. 

Given this table EmailEvents:

    SID   Date_SID    Email_SID   Type
    ----- ----------- ----------- -----------
    1     20160101    1           2           (Clicked)
    2     20160101    2           2
    3     20160102    2           2
    4     20160101    1           1           (Sent)
    5     20160101    2           1
    6     20151201    3           1
    7     20151201    3           2
    8     20151201    3           3           (Opened)

The rule would be: Every email that has at least one "Clicked" event should also have one "Opened" event and the date should be the same as the date of the first "Clicked" event.

The solution is..

    INSERT INTO [EmailEvents] (Date_SID, Email_SID, Type)
        SELECT
            Date_SID,
            Email_SID,
            3
        FROM (
            SELECT 
                Clicks.[Date_SID],
                Clicks.[Email_SID],
                ROW_NUMBER() OVER (PARTITION BY Clicks.[Email_SID] ORDER BY Clicks.[Date_SID]) AS Number,
                Opens.[SID] AS OpenEntrySID
            FROM 
                [EmailEvents] Clicks
            LEFT JOIN
                [EmailEvents] Opens ON Opens.Email_SID = Clicks.Email_SID AND Opens.Type = 3
            WHERE
                Clicks.Type = 2
        ) foo
        WHERE
            Number = 1 AND
            OpenEntrySID IS NULL


which results in...

    SID   Date_SID    Email_SID   Type
    ----- ----------- ----------- -----------
    1     20160101    1           2           (Clicked)
    2     20160101    2           2
    3     20160102    2           2
    4     20160101    1           1           (Sent)
    5     20160101    2           1
    6     20151201    3           1
    7     20151201    3           2
    8     20151201    3           3           (Opened)
    9     20160101    1           3
    10    20160101    2           3

