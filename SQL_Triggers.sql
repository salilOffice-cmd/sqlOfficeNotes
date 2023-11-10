/*****************************************************************************
       --                 SQL  Triggers
*****************************************************************************

What are Triggers in SQL Server?

1] Triggers are nothing but they are logic’s like stored procedures
   that can be executed automatically before the Insert,
   Update or Delete happens in a table or after the Insert, Update, 
   or Delete happens in a table. In simple words, we can say that, 

2] if you want to execute some pre-processing or post-processing 
   logic before or after the Insert, Update, or Delete in a table 
   then you need to use Triggers in SQL Server.



There are two types of triggers. They are as follows:
1] Instead of Triggers
2] After Triggers

Instead of Triggers: 
The Instead Of triggers are going 
to be executed instead of the corresponding DML operations. 
That means instead of the DML operations such as Insert, 
Update, and Delete, the Instead Of triggers are going to be executed.

After Triggers: 
The After Triggers fires in SQL Server execute after the triggering action. 
That means once the DML statement (such as Insert, Update, and Delete) 
completes its execution, this trigger is going to be fired.



1] DML Triggers – Data Manipulation Language Triggers.
2] DDL Triggers – Data Definition Language Triggers
3] CLR triggers – Common Language Runtime Triggers
4] Logon triggers



What are DML Triggers in SQL Server?
As we know DML Stands for Data Manipulation Language and 
it provides Insert, Update and Delete statements 
to perform the respective operation on the database 
tables or view which will modify the data. 
The triggers which are executed automatically 
in response to DML events (such as Insert, Update, and Delete statements) 
are called DML Triggers. */


-- Create Employee table
CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)
GO

-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)

/*************************************************************/
CREATE TRIGGER trInsertEmployee 
ON Employee
FOR INSERT
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM INSERT OPERATION'
  ROLLBACK TRANSACTION
END

/*************************************************************/

INSERT INTO Employee VALUES (6, 'Saroj', 7600, 'Male', 1)


---------------------------------------------
CREATE TRIGGER trUpdateEmployee 
ON Employee
FOR UPDATE
AS
BEGIn
  PRINT 'YOU CANNOT PERFORM UPDATE OPERATION'
  ROLLBACK TRANSACTION
END
--------------------------------------------

UPDATE Employee SET Salary = 90000 WHERE Id = 1



------------------------------------------------------------
CREATE TRIGGER trDeleteEmployee 
ON Employee
FOR DELETE
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM DELETE OPERATION'
  ROLLBACK TRANSACTION
END
-----------------------------------------------------------

DELETE FROM Employee WHERE Id = 1


/*
DROP TRIGGER trDeleteEmployee
DROP TRIGGER trInsertEmployee
DROP TRIGGER trUpdateEmployee
*/


CREATE TRIGGER trAllDMLOperationsOnEmployee 
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM DML OPERATION'
  ROLLBACK TRANSACTION
END


/*
Create a Trigger that will restrict all the DML operations on the Employee table on MONDAY only.

SUN DAY = 1
MON DAY = 2
TUE DAY = 3
WED DAY = 4
THU DAY = 5
FRI DAY = 6
SAT DAY = 7
*/



ALTER TRIGGER trAllDMLOperationsOnEmployee 
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  IF DATEPART(DW,GETDATE())= 2
  BEGIN
    PRINT 'DML OPERATIONS ARE RESTRICTED ON MONDAY'
    ROLLBACK TRANSACTION
  END
END


/*

Why do we need DML Triggers in SQL Server?

DML Triggers are used to enforce business rules and data integrity.
These triggers are very much similar to constraints in the 
way they enforce integrity. So, with the help of DML Triggers, 
we can enforce data integrity which cannot be done with the help of constraints that 
is comparing values with values of another table, etc. 



************************************************************
        Inserted and Deleted Tables in SQL Server
************************************************************

What are Inserted and Deleted Tables in SQL Server?

1] Inserted and Deleted tables are temporary tables that are 
   created by SQL Server in the context of a trigger. 
   That means these two tables can only be available as
   part of a trigger. 
   
2] If you try to access these tables 
   outside of a trigger, then you will get an error. 

3] The table structure of both inserted and deleted 
   tables will be exactly the same as the table structure of 
   the table on which the trigger is created.

4] Whenever you fire any INSERT, UPDATE, and DELETE statement on a table,
   all the new records are actually going to the inserted table i.e. 
   all the updated and new records are present in the inserted table.
   On the other hand, all the old values are present in the deleted table. */


-- Create Employee table
CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)
GO

-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)


CREATE TRIGGER trInsertEmployee 
ON Employee
FOR INSERT
AS
BEGIN
  SELECT * FROM INSERTED
END


INSERT INTO Employee VALUES (6, 'Saroj', 7700, 'Male', 2)

/*
What is Deleted Table in SQL Server?

1] The Deleted table is created by SQL Server when we perform 
   a delete operation on the table and this table has access to 
   the record being deleted. So, in simple words, we can say that, 
   
2] whenever we delete a record from a table the deleted record 
   information we can view with the help of the deleted table 
   as part of a trigger in SQL Server. */
   
------------------------------------------------
CREATE TRIGGER trDeleteEmployee 
ON Employee
FOR DELETE
AS
BEGIN
  SELECT * FROM DELETED
END  
-----------------------------------------------

DELETE FROM Employee WHERE Id = 6


-- How to view the updating data in a table?
-- Create Update Trigger
CREATE TRIGGER trUpdateEmployee 
ON Employee
FOR UPDATE
AS
BEGIN
  SELECT * FROM DELETED
  SELECT * FROM INSERTED
END


UPDATE Employee SET Name = 'Sharma', Salary = 8000 WHERE Id = 5


/**************************************************************************
--         DML Trigger Real-Time Examples in SQL Server
***************************************************************************

whenever we INSERT, UPDATE, or DELETE any data from a table,
then we need to make an entry into the audit table as well */

-- Create Employee table
CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)
GO

-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)



-- Create EmployeeAudit Table
CREATE TABLE EmployeeAudit
(
  ID INT IDENTITY(1,1) PRIMARY KEY,
  AuditData VARCHAR(MAX),
  AuditDate DATETIME
)

/*
Our business requirement is that whenever a new employee 
is added to the Employee table we want to capture 
the ID and name of the Employee and store the data 
into the EmployeeAudit table. The simplest way to 
achieve this is by using an AFTER TRIGGER for the INSERT event.
*/

CREATE TRIGGER tr_Employee_For_Insert
ON Employee
FOR INSERT
AS
BEGIN
  -- Declare a variable to hold the ID Value
  DECLARE @ID INT

  -- Declare a variable to hold the Name value
  DECLARE @Name VARCHAR(100)

  -- Declare a variable to hold the Audit data
  DECLARE @AuditData VARCHAR(100)

  -- Get the ID and Name from the INSERTED Magic table
  SELECT @ID = ID, @Name = Name FROM INSERTED

  -- Set the AuditData to be stored in the EmployeeAudit table
  SET @AuditData = 'New employee Added with ID  = ' + Cast(@ID AS VARCHAR(10)) + ' and Name ' + @Name

  -- Insert the data into the EmployeeAudit table
  INSERT INTO EmployeeAudit (AuditData, AuditDate) VALUES(@AuditData, GETDATE())
END



INSERT INTO Employee VALUES (6, 'Saroj', 3300, 'Male', 2)







