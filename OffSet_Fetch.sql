/* SQL Server OFFSET FETCH

The OFFSET and FETCH clauses are the options
of the ORDER BY clause. 
They allow you to limit the number of rows to be returned by a query. 

Note that you must use the OFFSET and FETCH clauses with
the ORDER BY clause. Otherwise, you will get an error.
*/
drop table Employees

CREATE TABLE Employees (
  Employee_Id INT PRIMARY KEY,
  FIRST_Name VARCHAR(100) NOT NULL,
  LAST_NAME VARCHAR(100) NOT NULL,
  jobid Int
);
-- Populate Employee Table
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1001, 'John','Thomson',121);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1002, 'Raj','Kumar',122);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1003, 'Jin','Thson',123);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1004, 'ohn','omson',124);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1005, 'nikhil','homson',125);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1006, 'Jdenn','homson',126);
INSERT INTO Employees (Employee_Id, FIRST_Name, LAST_NAME, jobid) VALUES (1007, 'wwohn','Thomson',127);

Select * 
from Employees


select *
from   Employees
ORDER BY Employee_Id
OFFSET 0 ROWS                         -- Skip the first 5 rows
FETCH NEXT 5 ROWS ONLY;           -- Retrieve the next 5 rows



DECLARE @PageNumber INT = 1;  -- The page number you want to retrieve
DECLARE @PageSize INT = 2;   -- Number of rows per page

-- Calculate the OFFSET and FETCH values based on the page number and page size
DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
DECLARE @Fetch INT = @PageSize;

-- Use OFFSET and FETCH in your query to retrieve the desired page
SELECT *
FROM Employee
ORDER BY Employee_Id                        -- Replace 'YourColumn' with the column you want to order by
OFFSET @Offset ROWS
FETCH NEXT @Fetch ROWS ONLY; 