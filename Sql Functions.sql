/*

SQL Server Usefull Function 

1]  CASE,
2]  IIF,
3]  ISNULL,
4]  COALESCE,
5]  CONVERT,
6]  CAST,
7]  SUBSTRING 
8]  Concat */

-- Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Birthdate DATE,
    Grade DECIMAL(4, 2),
    Score INT
);

-- Insert sample data into the Students table
INSERT INTO Students (StudentID, FirstName, LastName, Birthdate, Grade, Score)
VALUES
    (1, 'John', 'Doe', '1998-05-15', 85.25, 78),
    (2, 'Jane', 'Smith', '1999-02-21', 92.75, 90),
    (3, 'Robert', 'Johnson', '1997-11-10', 77.50, NULL),
    (4, 'Emily', 'Brown', '2000-04-02', 88.00, 85);



SELECT *
FROM Students;

SELECT FirstName, 
       LastName, 
	   CONVERT(VARCHAR(10), Birthdate,101) AS BirthdateString
FROM Students;


SELECT FirstName, 
       LastName, 
	   CONVERT(VARCHAR(10), Birthdate,101) AS BirthdateString
FROM Students;


SELECT FirstName, LastName, 
    CASE 
        WHEN Grade >= 90 THEN 'A'
        WHEN Grade >= 80 THEN 'B'
        WHEN Grade >= 70 THEN 'C'
        ELSE 'D'
    END AS GradeCategory
FROM Students;


SELECT FirstName, LastName,
    IIF (Score, 'Not Available', 'Score: ' + CAST(Score AS VARCHAR(10))) AS ScoreStatus
FROM Students;

SELECT FirstName, LastName, ISNULL(Score, 0) AS Score
FROM Students;



SELECT FirstName, LastName, COALESCE(Score, 0, 100) AS Score
FROM Students;



SELECT FirstName, LastName, CONVERT(VARCHAR(10), Birthdate, 101) AS BirthdateString
FROM Students;



SELECT FirstName, LastName, CAST(Grade AS INT) AS GradeAsInteger
FROM Students;



SELECT FirstName, LastName, SUBSTRING(FirstName, 1, 3) AS ShortFirstName
FROM Students;
