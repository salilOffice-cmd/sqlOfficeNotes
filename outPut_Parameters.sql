/*So basically if you would like your stored procedure to just return just a value instead of a data set
Input Parameters:

Used to pass values into a stored procedure.
Values are provided by the calling program or script.
Typically used for filtering or specifying criteria for the stored procedure to operate on.
Examples: @ParameterName INT, @ParameterName VARCHAR(50)
Output Parameters:

Used to return values from a stored procedure to the calling program or script.
Values are set within the stored procedure and retrieved by the calling program.
Typically used for returning calculated results, status information, or other output values.
Examples: @OutputParameterName INT OUTPUT, @OutputParameterName VARCHAR(50) OUTPUT
*/

-- Create a sample table for demonstration
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Salary DECIMAL(10, 2),
    DepartmentID INT
);

INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID)
VALUES (1, 'John', 50000, 1),
       (2, 'Jane', 60000, 1),
       (3, 'Bob', 70000, 2),
       (4, 'Alice', 80000, 2);

-- Create a stored procedure with output parameters
CREATE PROCEDURE GetDepartmentStats
    @DepartmentID INT,
    @TotalSalary DECIMAL(10, 2) OUTPUT,
    @AverageSalary DECIMAL(10, 2) OUTPUT
AS
BEGIN
    -- Declare a variable to store the total salary
    DECLARE @SumSalary DECIMAL(10, 2);

    -- Calculate the total salary for the department
    SELECT @SumSalary = SUM(Salary)
    FROM Employee
    WHERE DepartmentID = @DepartmentID;

    -- Calculate the average salary
    IF EXISTS (SELECT 1 FROM Employee WHERE DepartmentID = @DepartmentID)
        SET @AverageSalary = @SumSalary / (SELECT COUNT(*) FROM Employee WHERE DepartmentID = @DepartmentID);
    ELSE
        SET @AverageSalary = 0;

    -- Set the output parameters
    SET @TotalSalary = @SumSalary;
END;




/*
DECLARE @TotalSalaryResult DECIMAL(10, 2);
DECLARE @AverageSalaryResult DECIMAL(10, 2);

EXEC GetDepartmentStats @DepartmentID = 1, 
                        @TotalSalary = @TotalSalaryResult OUTPUT, 
						@AverageSalary = @AverageSalaryResult OUTPUT;

-- Display the results
SELECT TotalSalary = @TotalSalaryResult, AverageSalary = @AverageSalaryResult;

*/


/*
DECLARE @TotalSales DECIMAL(18, 2);

EXEC GetTotalSales
    @StartDate = '2023-01-01',
    @EndDate = '2023-12-31',
    @TotalSales = @TotalSales OUTPUT;

-- Display the result
PRINT 'Total Sales: ' + CAST(@TotalSales AS VARCHAR(20));

*/




CREATE PROCEDURE GetTotalSales
    @StartDate DATE,
    @EndDate DATE,
    @TotalSales DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SELECT @TotalSales = SUM(SalesAmount)
    FROM Sales
    WHERE OrderDate BETWEEN @StartDate AND @EndDate;
END;





/*
DECLARE @EmployeeID INT, @Success BIT;

EXEC UpdateEmployeeSalary
    @EmployeeID = 1,
    @NewSalary = 60000,
    @Success = @Success OUTPUT;

-- Display the result
IF @Success = 1
    PRINT 'Salary updated successfully.';
ELSE
    PRINT 'No matching employee found.';

*/

CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2),
    @Success BIT OUTPUT
AS
BEGIN
    UPDATE Employee
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;

    IF @@ROWCOUNT > 0
        SET @Success = 1; -- Successful update
    ELSE
        SET @Success = 0; -- No rows updated
END;



/*
DECLARE @EmployeeID INT;

EXEC InsertEmployee
    @Name = 'New Employee',
    @DepartmentID = 1,
    @EmployeeID = @EmployeeID OUTPUT;

-- Display the generated EmployeeID
PRINT 'New Employee ID: ' + CAST(@EmployeeID AS VARCHAR(20));

*/


CREATE PROCEDURE InsertEmployee
    @Name VARCHAR(255),
    @DepartmentID INT,
    @EmployeeID INT OUTPUT
AS
BEGIN
    INSERT INTO Employee (Name, DepartmentID)
    VALUES (@Name, @DepartmentID);

    SET @EmployeeID = SCOPE_IDENTITY();
END;
