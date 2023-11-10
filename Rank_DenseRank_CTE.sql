/***********************************************************
         -- OVER Clause in SQL Server:
************************************************************

1] The OVER clause in SQL Server is used with PARTITION BY 
to break up the data into partitions. Following is the syntax of the OVER clause. 



************************************************************
          Row_Number Function in SQL Server
*************************************************************

1] The ROW_NUMBER function is basically used when you want 
   to return a sequential number starting from 1.

2] The ROW_NUMBER function is basically used when
   you want to return a sequential number starting from 1.




PARTITION BY value_expression:
This is optional. The PARTITION BY clause is used to 
divide the result set that is produced by the FROM
clause into partitions and then the ROW_NUMBER 
function is applied to each partition. Here, 
the value_expression specifies the column name (s) 
using which the result set is going to be partitioned. 
As it is optional, if you did not specify the PARTITION BY clause,
then the ROW_NUMBER function will treat all the rows of the query as a single group.

Order_by_clause:
It is required. The ORDER BY clause is basically used 
to define the sequence in which each row is 
going to assign its unique ROW_NUMBER.


Note: If you did not use the PARTITION BY clause with the ROW_NUMBER function, 
then the result set will consider as a single partition. */


CREATE TABLE Employees
(
     ID INT,
     Name VARCHAR(50),
     Department VARCHAR(50),
     Salary int
)
Go

INSERT INTO Employees Values (1, 'James', 'IT', 15000)
INSERT INTO Employees Values (2, 'Smith', 'IT', 35000)
INSERT INTO Employees Values (3, 'Rasol', 'HR', 15000)
INSERT INTO Employees Values (4, 'Rakesh', 'Payroll', 35000)
INSERT INTO Employees Values (5, 'Pam', 'IT', 42000)
INSERT INTO Employees Values (6, 'Stokes', 'HR', 15000)
INSERT INTO Employees Values (7, 'Taylor', 'HR', 67000)
INSERT INTO Employees Values (8, 'Preety', 'Payroll', 67000)
INSERT INTO Employees Values (9, 'Priyanka', 'Payroll', 55000)
INSERT INTO Employees Values (10, 'Anurag', 'Payroll', 15000)
INSERT INTO Employees Values (11, 'Marshal', 'HR', 55000)
INSERT INTO Employees Values (12, 'David', 'IT', 96000)
 
-- Row_Num without partition 

Select * from Employees

 SELECT [Name], 
        Department, 
		Salary,
        ROW_NUMBER() OVER (ORDER BY Department) AS RowNumber

FROM    Employees

/* Note: If you did not specify the ORDER BY clause then you will 
get the error stating
“The function ‘ROW_NUMBER’ must have an OVER clause with ORDER BY”. */


SELECT [Name], 
       [Department], 
	   [Salary],
       ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Name) AS RowNumber
FROM   Employees



-- TRUNCATE TABLE Employees

INSERT INTO Employees Values (1, 'James', 'IT', 15000)
INSERT INTO Employees Values (1, 'James', 'IT', 15000)
INSERT INTO Employees Values (2, 'Rasol', 'HR', 15000)
INSERT INTO Employees Values (2, 'Rasol', 'HR', 15000)
INSERT INTO Employees Values (2, 'Rasol', 'HR', 15000)
INSERT INTO Employees Values (3, 'Stokes', 'HR', 15000)
INSERT INTO Employees Values (3, 'Stokes', 'HR', 15000)
INSERT INTO Employees Values (3, 'Stokes', 'HR', 15000)
INSERT INTO Employees Values (3, 'Stokes', 'HR', 15000)

-- Now, intentionally we have inserted some duplicate data into the Employees table as shown below.

select *
from   Employee


 SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RowNumber

FROM    Employees



WITH DeleteDuplicateCTE AS
(
     SELECT *, ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
     FROM Employees
)
DELETE FROM DeleteDuplicateCTE WHERE RowNumber > 1

/************************************************************************
           Rank and Dense_Rank Function in SQL Server
************************************************************************* */

Create Table Employees
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50), 
    Department VARCHAR(10),
    Salary INT,
)
Go

Insert Into Employees Values (1, 'James', 'IT', 80000)
Insert Into Employees Values (2, 'Taylor', 'IT', 80000)
Insert Into Employees Values (3, 'Pamela', 'HR', 50000)
Insert Into Employees Values (4, 'Sara', 'HR', 40000)
Insert Into Employees Values (5, 'David', 'IT', 35000)
Insert Into Employees Values (6, 'Smith', 'HR', 65000)
Insert Into Employees Values (7, 'Ben', 'HR', 65000)
Insert Into Employees Values (8, 'Stokes', 'IT', 45000)
Insert Into Employees Values (9, 'Taylor', 'IT', 70000)
Insert Into Employees Values (10, 'John', 'IT', 68000)
Go

-- without partition

SELECT Name,
       Department, 
	   Salary,
       RANK() OVER (ORDER BY Salary DESC) AS [Rank]

FROM Employees

/*
The Rank function in SQL Server skips the ranking(s) 
when there is a tie. As you can see in the above output, 
Ranks 2 and 6 are skipped as there are 2 rows 
at rank 1 as well as 2 rows at rank 5. The third row 
gets rank 3 and the 7th row gets rank 7.
*/


SELECT Name, 
       Department, 
	   Salary,
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS [Rank]
FROM Employees 


/*****************************************************
        DENSE_RANK Function in SQL Server:
*******************************************************/

SELECT Name, Department, Salary,
            DENSE_RANK() OVER (ORDER BY Salary DESC) AS [Rank]
FROM Employees



SELECT Name, Department, Salary,
               DENSE_RANK() OVER (
                               PARTITION BY Department
                               ORDER BY Salary DESC) AS [DenseRank]
FROM Employees


SELECT Name, Department, Salary,
              ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RowNumber,
			  RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS [Rank],
			  DENSE_RANK() OVER (
                               PARTITION BY Department
                               ORDER BY Salary DESC) AS [DenseRank]
FROM Employees

/*****************************************************
Fetch the 2nd Highest Salary using the RANK function: */

-- Fetch the 2nd Hight Salary
WITH EmployeeCTE  AS
(
    SELECT Salary, RANK() OVER (ORDER BY Salary DESC) AS Rank_Salry
    FROM Employees
)

SELECT TOP 1 Salary 
FROM   EmployeeCTE WHERE Rank_Salry = 2


-- Fetch the 2nd Highest Salary using DENSE_RANK Function:

-- Fetch the 2nd Hight Salary
WITH EmployeeCTE  AS
(
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank_Salry
    FROM Employees
)

SELECT TOP 1 Salary FROM EmployeeCTE WHERE DenseRank_Salry = 2



-- Example to find the Highest Salary Department wise:

WITH EmployeeCTE  AS
(
    SELECT Salary, Department,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC)
           AS Salary_Rank
    FROM Employees
)

SELECT TOP 1 Salary FROM EmployeeCTE WHERE Salary_Rank = 3
AND Department = 'IT'