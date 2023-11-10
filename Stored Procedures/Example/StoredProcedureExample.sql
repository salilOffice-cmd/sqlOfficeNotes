----------------------------------------------------

CREATE PROCEDURE spDisplayWelcome
AS
BEGIN
  PRINT 'WELCOME TO PROCEDURE in SQL Server'
END

/*------------------------------------------------------


Calling a Stored Procedure: */

EXECUTE spDisplayWelcome

EXEC spDisplayWelcome

spDisplayWelcome

------------------------------------------------------



-- Create Employee Table
CREATE TABLE Employee
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  DeptID INT
)
GO

-- Populate the Employee Table with test data
INSERT INTO Employee VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO Employee VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO Employee VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO Employee VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
INSERT INTO Employee VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO Employee VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)
GO

----------------------------------------------

CREATE PROCEDURE spGetEmployee
AS
BEGIN
  Select Name, Gender, DOB from Employee
END

-----------------------------------------------

-- To Execute the Procedure
EXEC spGetEmployee

-------------------------------------------------



CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
  @Gender VARCHAR(20),
  @DeptID INT
AS
BEGIN
  SELECT Name, Gender, DOB, DeptID 
  FROM Employee
  WHERE Gender = @Gender AND DeptID = @DeptID
END
GO


--------------------------------------------------------------

-- Create a Procedure
CREATE PROCEDURE spUpdateEmployeeByID
(
  @ID INT, 
  @Name VARCHAR(50), 
  @Gender VARCHAR(50), @DOB DATETIME, 
  @DeptID INT
)
AS
BEGIN
  UPDATE Employee SET 
      Name = @Name, 
      Gender = @Gender,
      DOB = @DOB, 
      DeptID = @DeptID
  WHERE ID = @ID
END
GO

-- Executing the Procedure
-- If you are not specifying the Parameter Names then the order is important
EXECUTE spUpdateEmployeeByID 3, 
                             'Palak', 
							 'Female',
							 '1994-06-17 10:53:27.060',
							 3

-- If you are specifying the Parameter Names then order is not mandatory
EXECUTE spUpdateEmployeeByID @ID =3, 
                             @Gender = 'Female', 
							 @DOB = '1994-06-17 10:53:27.060',
							 @DeptID = 3, 
							 @Name = 'Palak'