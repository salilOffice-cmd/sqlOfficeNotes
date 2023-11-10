CREATE TABLE Employee (
  Id INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Department VARCHAR(100) NOT NULL,
  Salary FLOAT NOT NULL,
  Gender VARCHAR(45) NOT NULL,
  Age INT NOT NULL,
  City VARCHAR(45) NOT NULL
);

-- Populate Employee Table
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1001, 'John Doe', 'IT', 35000, 'Male', 25, 'London');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1002, 'Mary Smith', 'HR', 45000, 'Female', 27, 'London');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1003, 'James Brown', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1004, 'Mike Walker', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1005, 'Linda Jones', 'HR', 75000, 'Female', 26, 'London');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1006, 'Anurag Mohanty', 'IT', 35000, 'Male', 25, 'Mumbai');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1007, 'Priyanla Dewangan', 'HR', 45000, 'Female', 27, 'Mumbai');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1008, 'Sambit Mohanty', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1009, 'Pranaya Kumar', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, Name, Department, Salary, Gender, Age, City) VALUES (1010, 'Hina Sharma', 'HR', 75000, 'Female', 26, 'Mumbai');

-- Create Projects Table
CREATE TABLE Projects (
    ProjectId INT PRIMARY KEY IDENTITY(1, 1),
    Title VARCHAR(200) NOT NULL,
    ClientId INT,
    EmployeeId INT,
    StartDate DATETIME,
    EndDate DATETIME,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id)
);

-- Populate Projects Table
INSERT INTO Projects (Title, ClientId, EmployeeId, StartDate, EndDate) VALUES 
('Develop ecommerse website from scratch', 1, 1003, GETDATE(), (Getdate() + 35)),
('WordPress website for our company', 1, 1002, GETDATE(), (Getdate() + 45)),
('Manage our company servers', 2, 1007, GETDATE(), (Getdate() + 55)),
('Hosting account is not working', 3, 1009, GETDATE(), (Getdate() + 65)),
('MySQL database from my desktop application', 4, 1010, GETDATE(), (Getdate() + 75)),
('Develop new WordPress plugin for my business website', 2, NULL, GETDATE(), (Getdate() + 85)),
('Migrate web application and database to new server', 2, NULL, GETDATE(), (Getdate() + 95)),
('Android Application development', 4, 1004, GETDATE(), (Getdate() + 60)),
('Hosting account is not working', 3, 1001, GETDATE(), (Getdate() + 70)),
('MySQL database from my desktop application', 4, 1008, GETDATE(), (Getdate() + 80)),
('Develop new WordPress plugin for my business website', 2, NULL, GETDATE(), (Getdate() + 90));



/***********************************************************/
     -- Questions
/**********************************************************



1] Write a SQL query to retrieve the names of employees 
   along with the titles of the projects they are assigned to.

2] Perform a SQL join to fetch the projects and their corresponding client names.

3] List all employees and their project titles, 
   including those who are not assigned to any project.


4] Write a SQL query to calculate the average salary for each department.

5] Find the total count of employees in each city.

6] Calculate the maximum age of employees in each department.


7] Retrieve the names of employees and their corresponding departments, 
replacing NULL department values with 'Not assigned'.

8] Display the project titles and employee names.
Replace NULL employee names with 'Unassigned'.


9] Show employee names and a column indicating 
 whether their salary is above 50000 or not.

10] Use a CASE statement to categorize employees into
'Young' if their age is below 30, and 'Old' if 30 or above.


11] Retrieve the names of employees who are from London.

12] List the project titles for projects that have not started yet.


13] Calculate the average salary of employees for 
  each department and display only those departments 
  with an average salary greater than 40000.


14] Display the project titles and their total count. 
Show only projects with more than 2 employees assigned.


15] Retrieve the top 3 highest earning employees.

16] Show the project titles for the 5 most recently started projects.


17] List employees earning a salary greater than 45000 and aged between 25 and 30.

18] Display projects where the start date is after today.

19] Find employees with a salary equal to or greater than 50000 and whose name contains 'James'.

20] Retrieve projects with titles starting 
with 'Develop' and having a client ID in (1, 2).

