
UPDATE with JOIN (T-SQL)
========================

Problem: Your have a table with rows of different types (1, 2, 3) and you want to update the User_Id column of all rows with Type > 1 and User_Id = -1 to the right User_Id. This User_Id can be found in the corresponding row with the same Email_Id and Type = 1.

Given this table Test:

    User_Id     Email_Id    Type
    ----------- ----------- -----------
     1          10          1
    -1          10          2
    12          11          1
    -1          11          2
    -1          11          2
    -1          11          3

The goal is to set all User_Ids that have currently the value -1 to the correct value 
which can be looked up in the corresponding row (Email_Id) with Type = 1.

The next query pairs the corresponding rows:

    SELECT * FROM [Test] Target
    LEFT JOIN [Test] Source ON Source.Email_Id = Target.Email_Id
    WHERE Target.User_Id = -1 AND Source.Type = 1 

    User_Id     Email_Id    Type        User_Id     Email_Id    Type
    ----------- ----------- ----------- ----------- ----------- -----------
    -1          10          2           1           10          1
    -1          11          2           12          11          1
    -1          11          2           12          11          1
    -1          11          3           12          11          1

To update the User_Id in the first column with the value of the fourth column we can edit the query in this way:

    UPDATE Target
    SET Target.User_Id = Source.User_Id
    FROM [Test] AS Target
    LEFT JOIN [Test] Source ON Source.Email_Id = Target.Email_Id
    WHERE Target.User_Id = -1 AND Source.Type = 1 

which results in...

    User_Id     Email_Id    Type
    ----------- ----------- -----------
     1          10          1
     1          10          2
    12          11          1
    12          11          2
    12          11          2
    12          11          3

