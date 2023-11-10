/**************************************************************
             -- CTE in SQL Server
***************************************************************

A Common Table Expression (CTE) is a temporary result set that you can 
reference within a SELECT, INSERT, UPDATE, 
or DELETE statement. 

CTEs are defined using the WITH keyword and are
useful for simplifying complex queries, 
making them more readable and manageable.
*/


-- Create the Employees table
CREATE TABLE Employeesss (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ManagerID INT
);
-- Insert sample data
INSERT INTO Employeesss (EmployeeID, FirstName, LastName, ManagerID)
VALUES
    (1, 'John', 'Doe', NULL),
    (2, 'Jane', 'Smith', 1),
    (3, 'Robert', 'Johnson', 1),
    (4, 'Lisa', 'Williams', 3),
    (5, 'Michael', 'Brown', 2),
    (6, 'Sarah', 'Davis', 2),
    (7, 'David', 'Wilson', NULL);


select *
from Employeesss


WITH EmployeeCTE AS (
    SELECT EmployeeID, 
	       FirstName, 
		   LastName, 
		   ManagerID
    FROM   Employeesss
)
SELECT  FirstName AS EmployeeName, 
        FirstName AS ManagerName
FROM    EmployeeCTE 


-- Define the CTE to insert data
;WITH EmployeeToInsert AS (
    SELECT 8 AS EmployeeID, 
   'Mary' AS FirstName, 
   'Jones' AS LastName, 
      1 AS ManagerID
)
-- Insert the data from the CTE into the Employees table
INSERT INTO Employeesss (EmployeeID, FirstName, LastName, ManagerID)
SELECT EmployeeID, FirstName, LastName, ManagerID
FROM EmployeeToInsert;




-- Define the CTE to update data
;WITH EmployeeToUpdate AS (
    SELECT EmployeeID, 'Johnson' AS NewLastName
    FROM Employeesss
    WHERE FirstName = 'Robert'
)
-- Update the data in the Employees table based on the CTE
UPDATE Employeesss
SET LastName = NewLastName
FROM EmployeeToUpdate;



-- Define the CTE to select employees to delete
WITH EmployeeToDelete AS (
    SELECT EmployeeID
    FROM Employeesss
    WHERE FirstName = 'David'
)
-- Delete the selected employees based on the CTE
DELETE FROM Employeesss
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeToDelete);




;WITH EmployeeCTE1 AS (
    SELECT EmployeeID, 
	       FirstName, 
		   LastName, 
		   ManagerID
    FROM   Employeesss
)
SELECT e.FirstName AS EmployeeName, 
       m.FirstName AS ManagerName
FROM   EmployeeCTE1 e
LEFT JOIN EmployeeCTE1 m ON e.ManagerID = m.EmployeeID;




