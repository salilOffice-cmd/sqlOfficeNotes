/************************************************
         --   SQL Server Subquery
*************************************************

A subquery is a query nested inside another statement 
such as SELECT, INSERT, UPDATE, or DELETE.

A subquery, also known as an inner query or nested query, 
is a query nested inside another query. 
Subqueries are used to retrieve data that will be 
used in the main query to perform additional operations. 

They are often used for filtering, calculations, and comparisons.*/

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50)
);

-- Insert sample data into the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, City)
VALUES
    (1, 'John', 'Doe', 'New York'),
    (2, 'Jane', 'Smith', 'Los Angeles'),
    (3, 'Robert', 'Johnson', 'Chicago'),
    (4, 'Lisa', 'Williams', 'New York'),
    (5, 'Michael', 'Brown', 'Los Angeles');

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data into the Orders table
INSERT INTO Orders (OrderID, OrderDate, CustomerID)
VALUES
    (101, '2023-10-01', 1),
    (102, '2023-10-02', 2),
    (103, '2023-10-03', 1),
    (104, '2023-10-04', 4),
    (105, '2023-10-05', 3);

Select * from Customers
Select * from Orders



-- Sample SQL query using a subquery with two tables
SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Customers
    WHERE City = 'New York'
);

SELECT CITY
FROM CUSTOMERS
WHERE CUSTOMERID IN(
       SELECT CUSTOMERID
	   FROM ORDERS
	   WHERE ORDERID = 101
);

DROP TABLE CUSTOMERS
DROP TABLE ORDERS
--------------------------------------------------------------------------

-- Create the drop table Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50)
);

-- Insert sample data into the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, City)
VALUES
    (1, 'John', 'Doe', 'New York'),
    (2, 'Jane', 'Smith', 'Los Angeles'),
    (3, 'Robert', 'Johnson', 'Chicago'),
    (4, 'Lisa', 'Williams', 'New York'),
    (5, 'Michael', 'Brown', 'Los Angeles');

-- Create the drop table Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2), -- Assuming you want to include TotalAmount
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data into the Orders table
INSERT INTO Orders (OrderID, OrderDate, CustomerID, TotalAmount)
VALUES
    (101, '2023-10-01', 1, 250.00),
    (102, '2023-10-02', 2, 150.00),
    (103, '2023-10-03', 1, 300.00),
    (104, '2023-10-04', 4, 450.00),
    (105, '2023-10-05', 3, 175.00);

---------------------------------------------------------------------------
Select * from Customers
Select * from Orders





SELECT OrderID, OrderDate,TotalAmount
FROM Orders
WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe');


SELECT OrderID, 
       TotalAmount,
	   OrderDate
FROM   Orders
WHERE  TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);


SELECT CustomerID, FirstName, LastName,
       (SELECT SUM(TotalAmount) 
	   FROM Orders 
	   WHERE Orders.CustomerID = Customers.CustomerID) AS TotalOrderAmount
FROM  Customers;



SELECT CustomerID, FirstName, LastName,
       (SELECT COUNT(*) 
	   FROM Orders 
	   WHERE Orders.CustomerID = Customers.CustomerID) AS OrderCount
FROM Customers;



INSERT INTO Orders (OrderID, OrderDate, CustomerID)
VALUES (106, '2023-10-06', (SELECT CustomerID FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson' ));







