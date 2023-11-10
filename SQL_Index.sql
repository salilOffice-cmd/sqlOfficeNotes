/**************************************************************************************
                                 SQL  INDEX
-**************************************************************************************


What is an Index in SQL Server?

1] It is a database object in SQL Server which is used to 
   improve the performance of search operations.

2] When we create an index on any column of a table, 
   then SQL Server internally maintains a separate table called the index table. 
   And when we are trying to retrieve the data from the existing table, 
   depending on the index table, 
   SQL Server directly goes to the table and retrieves the data very quickly.

3] In a table, we can use a maximum of 1000 indexes 
   (1 Clustered Index plus 999 Non-Clustered Index).



How will the database engine retrieve the data from a table in SQL Server?

Whenever the database engine wants to retrieve the data from a database table it
will adopt two different mechanisms for searching the data

1] Table scan
2] Index Scan/Seek

What is Table Scan in SQL Server?
In Table Scan, the SQL Server Search Engine will search for the 
required information sequentially one by one from the start to the last record of the table.
If the table has more rows, then it will take more time for searching 
the required data, so it is a time-consuming process.


ex:-
Suppose, you want to search the value 50, 
then the search engine (i.e. SQL Server Search Engine) 
will scan the record sequentially one by one from the beginning 
i.e. from 1, and until it reaches the value 50. If you want 
to increase the search performance, then somehow you have to
minimize the number of scans. That is what exactly 
the B-Tree (Balanced Tree) does.



What is Index Scan/Seek in SQL Server?

In Index Scan, the SQL Server Search Engine uses 
a B-Tree structure to search the required data which drastically 
improves the performance of your search query by reducing 
the number of scans. So, let us first understand what 
B-Tree structure is and how it reduces the number scan 
which ultimately improves the performance of your search query.


Understanding the Balanced Tree (B-Tree) in SQL Server:
Whenever you create an index (or indexes) on some column(s)
of a table in SQL Server then what happens internally is,
it creates a B-Tree structure. In the B-Tree structure, 
the data is divided into three sections i.e. Root Node, 
Non-Leaf Nodes, and Leaf Nodes. In order to understand 
this better please have a look at the following image 
which shows how the data is divided and stored. As you 
can see, in the Root Node it has 30 and 50. In the 
Non-Leaf node, it has 10, 30, 40, and 50. And in the
leaf node, we have the actual data. So, the leaf 
node is actually pointing to data.


Suppose, you want to search 50 here, then what will happen internally is, 
the search engine will start the search from the root node. 
It will check whether 50 is less than or equal to 30. 
As 50 is not less than or equal to 30, so the non-leaf 
nodes and leaf nodes that come under the root node 30 
are completely bypassed.

Then it will go to the next node i.e. 50 and check 
whether 50 is less than or equal to 50. And the 
condition satisfies here. Then it goes to the non-leaf nodes 
(40, 50) which are under the root node 50. It will check whether 
50 is less than or equal to 40 and the condition fail, so, 
it will bypass all the leaf nodes which come under the non-leaf node 40. 
Then it will check the other non-leaf node i.e. 50 and here the 
condition satisfies as 50 equals 50 and it goes to scan the
leaf node sequentially. That is, it approximately scans 10 records.*/


CREATE TABLE Employee
(
 Id INT,
 Name VARCHAR(50),
 Salary INT,
 Gender VARCHAR(10),
 City VARCHAR(50),
 Dept VARCHAR(50)
)
GO

INSERT INTO Employee VALUES (3,'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employee VALUES (1,'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employee VALUES (4,'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employee VALUES (5,'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employee VALUES (7,'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (6,'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employee VALUES (2,'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employee VALUES (8,'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (10,'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employee VALUES (9,'Sara', 500, 'Female', 'London', 'IT')


SELECT * FROM Employee Where Id = 8

/*

When SQL Server uses Indexes?
The SQL Server uses indexes of a table provided 
that the select or update or delete statement 
contained the “WHERE” clause and moreover the
where condition column must be an indexed column. 
If the select statement contains an “ORDER BY” 
clause then also the indexes can be used.


Note: When SQL Server is searching for information under the database, 
first it will verify the best execution plan for retrieving the 
data and uses that plan which can be either a full-page scan or an index scan.


The syntax for creating an Index in SQL Server:
CREATE [UNIQUE] [CLUSTERED/ NON-CLUSTERED] INDEX <INDEX NAME> ON <TABLE NAME> (<COLUMN LIST>)
To see the index: sp_helpindex Employee
To drop an index: Drop index Employee.IX_Employee_Id




Types of indexes in SQL Server
SQL Server Indexes are divided into two types. They are as follows:

Clustered index
Non-Clustered index
What is SQL Server Clustered index?
The Clustered Index in SQL Server defines the order 
in which the data is physically stored in a table.
In the case of a clustered index, 
the leaf node store the actual data.
As the leaf nodes store the actual 
data a table can have only one clustered index. 
The Clustered Index by default was created when 
we created the primary key constraint for that table.
That means the primary key column creates a clustered index by default.

When a table has a clustered index then that 
table is called a clustered table.
If a table has no clustered index its data rows are stored in an unordered structure.

What is SQL Server Non-Clustered Index?
In SQL Server Non-Clustered Index, 
the arrangement of data in the index 
table will be different from the arrangement of data in the actual table. 
The data is stored in one place and the index is stored in another place. 
Moreover, the index will have pointers to the storage location of the actual data.


