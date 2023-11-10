/*****************************************************************************
          Select Into , Insert Into , Temp Table 
******************************************************************************


The SQL SELECT INTO Statement

The SELECT INTO statement copies data from one table into a new table.


SELECT *
INTO newtable [IN externaldb]
FROM oldtable
WHERE condition;

The following SQL statement copies data from more than one table into a new table:

SELECT Customers.CustomerName, Orders.OrderID
INTO CustomersOrderBackup2017
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;



Tip: SELECT INTO can also be used to create a new,
empty table using the schema of another. 
Just add a WHERE clause that causes the query to return no data:

SELECT * INTO newtable
FROM oldtable
WHERE 1 = 0;

*/


CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, first_name, last_name, department, salary)
VALUES
    (1, 'John', 'Doe', 'HR', 50000.00),
    (2, 'Jane', 'Smith', 'Sales', 60000.00),
    (3, 'Bob', 'Johnson', 'IT', 75000.00),
    (4, 'Alice', 'Brown', 'Finance', 70000.00);


/*
You want to create a new table called "high_earners" to store information 
about employees with a salary greater than $70,000. */


SELECT employee_id, first_name, last_name, salary
INTO high_earners
FROM employees
WHERE salary > 70000.00;



/*********************************************************************************************

The SQL INSERT INTO SELECT Statement

1] The INSERT INTO SELECT statement copies data from one table and inserts it into another table.

2] The INSERT INTO SELECT statement requires that the data types in source and target tables match.

3]  Note: The existing records in the target table are unaffected.



Copy all columns from one table to another table:

INSERT INTO table2
SELECT * FROM table1
WHERE condition;


Copy only some columns from one table into another table:

INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition;


*/


CREATE TABLE employeess (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employeess (employee_id, first_name, last_name, department, salary)
VALUES (5, 'Ella', 'Johnson', 'Marketing', 62000.00);







CREATE TABLE new_hires (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);



INSERT INTO new_hires (employee_id, first_name, last_name, department, salary)
SELECT employee_id, first_name, last_name, department, salary
FROM employeess
WHERE department = 'Sales';


select *
from   new_hires
