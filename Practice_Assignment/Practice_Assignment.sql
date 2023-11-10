
use Sdirect_Khilesh_Practice

/************************************************/
--          SQL Practice Assignment
/************************************************/

-- Create one new Database and execute below tables to solve questions


CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(50),
    CourseID INT
);
 
INSERT INTO Students (StudentID, StudentName, CourseID)
VALUES
    (1, 'John Doe', 101),
    (2, 'Jane Smith', 102),
    (3, 'Bob Johnson', 101),
    (4, 'Alice Brown', 103),
    (5, 'Emily White', 102),
    (6, 'John Doe', 101);
 
 drop table Courses

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(50)
);
 
INSERT INTO Courses (CourseID, CourseName)
VALUES
    (101, 'Mathematics'),
    (102, 'History'),
    (103, 'Physics'),
    (104, 'Computer Science'),
    (105, 'Mathematics');

Select * 
From Students

Select *
From Courses




/*1] Write a SQL query using a Common Table Expression to list all students who are enrolled in the 'Mathematics' course.*/
Select * 
From Students

Select *
From Courses


;WITH StudentCTE1 AS (
       SELECT 
	       e.StudentName,
		   m.CourseName
   FROM   Students e
JOIN Courses m ON e.CourseID = m.CourseID
)
SELECT StudentName as SName
from StudentCTE1
Where CourseName ='Mathematics';



/*2] Create a CTE that counts the number of duplicate student records in the 'Students' table.*/

select * from Students

;WITH StudentCTEs AS (
                      SELECT StudentName,count(*) as CountofStudent
		              From Students
					  Group by StudentName
					  Having COUNT(*) > 1
				   )
				   Select StudentName as TotalStudentCount,
				          CountofStudent
				   From StudentCTEs



 
/*3] Write a CTE query to find the average number of courses each student is enrolled in.*/

Select * from Students
Select * from courses

;WITH StudentCTE1 AS (
       SELECT 
	         e.StudentName,
			 count(m.CourseName) as CourseName,			
			 avg(m.CourseId) as TotalCourse
       FROM   Students e
       JOIN Courses m ON e.CourseID = m.CourseID
       group by e.StudentName
	   Having COUNT(m.CourseName) > 0
)
SELECT *
from StudentCTE1

 
/*4] Create a CTE that joins the 'Students' and 'Courses' tables to list the names of students along with the courses they are enrolled in.*/
Select * from Students

;WITH StudentCTE1 AS (
       SELECT 
	       e.StudentName,
		   m.CourseName
   FROM   Students e
JOIN Courses m ON e.CourseID = m.CourseID
)
SELECT *
from StudentCTE1




********************************************************************************************************/

-- Create Below tables if required drop above tables and create below 

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);
 
INSERT INTO Student (StudentID, FirstName, LastName, Age)
VALUES
    (1, 'John', 'Doe', 20),
    (2, 'Jane', 'Smith', 22),
    (3, 'Mike', 'Johnson', 21),
    (4, 'Sarah', 'Davis', 19),
    (5, 'John', 'Doe', 20),
    (6, 'David', 'Wilson', 23);
 
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Instructor VARCHAR(50)
);
 
INSERT INTO Course (CourseID, CourseName, Instructor)
VALUES
    (101, 'Mathematics', 'Professor Smith'),
    (102, 'History', 'Professor Johnson'),
    (103, 'Physics', 'Professor Davis'),
    (104, 'Mathematics', 'Professor Smith'),
    (105, 'Biology', 'Professor Wilson'),
    (106, 'Computer Science', 'Professor Smith');
 


/*1] Write an SQL query to retrieve the first and last names of students who have the same first and last name as other students.*/
 Select * from Student

 SELECT A.StudentID,A.FirstName,A.LastNAME
 FROM STUDENT A, STUDENT B
 WHERE A.FirstNAME = B.FirstNAME
    AND A.LastNAME = B.LastNAME
    AND A.StudentID! = B.StudentID;



/*2] Create an SQL query to list the course names that are taught by instructors whose names contain the word "Smith."
 select * from Course*/
 select * from Course

  Select CourseName,count(*) as TotalCountofCourse
  From Course 
  Where Instructor Like '%Smith'
  group by CourseName

    

 
/*3] Write an SQL query to count the number of courses that have the same name as other courses.*/
select * from Course

SELECT A.CourseName,Count(*) as TotalCount
FROM Course A, Course B
WHERE A.CourseName = B.CourseName   
	group by A.CourseName
	Having COUNT(*) > 0

 
4] Write an SQL query to find the students who are enrolled in the same courses as a specific student (e.g., John Doe).*/

/*********************************************************************************************************************************/

-- Note :- Based on below tables create stored procedure 

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(15)
);
 
INSERT INTO Patients (PatientID, FirstName, LastName, Age, Gender, ContactNumber)
VALUES
    (1, 'John', 'Doe', 35, 'Male', '123-456-7890'),
    (2, 'Jane', 'Smith', 28, 'Female', '987-654-3210'),
    (3, 'Mike', 'Johnson', 45, 'Male', '555-555-5555'),
    (4, 'Sarah', 'Davis', 30, 'Female', '777-123-4567');


CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(50),
    ContactNumber VARCHAR(15)
);
 
INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialization, ContactNumber)
VALUES
    (101, 'Dr. David', 'Wilson', 'Cardiologist', '111-222-3333'),
    (102, 'Dr. Emily', 'Brown', 'Pediatrician', '444-555-6666'),
    (103, 'Dr. Robert', 'White', 'Dermatologist', '777-888-9999'),
    (104, 'Dr. Lisa', 'Lee', 'Orthopedic Surgeon', '222-111-4444');



CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    AppointmentReason VARCHAR(100)
);
 
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, AppointmentReason)
VALUES
    (1001, 1, 101, '2023-11-10', '09:30:00', 'Chest pain'),
    (1002, 2, 102, '2023-11-15', '15:00:00', 'Child''s checkup'),
    (1003, 3, 103, '2023-11-20', '11:45:00', 'Skin rash'),
    (1004, 4, 104, '2023-11-25', '14:15:00', 'Knee pain');

select * from Patients
select * from Appointments
select * from  Doctors

/*Create a Stored Procedure to Add a New Patient:
1] Create a stored procedure that takes input parameters 
   for a new patient's first name, last name, age, gender,
   and contact number, and inserts a new patient into the Patients table.*/
/*
Title:			1) SpPatientsdb_sel

                2) SpPatientsdb_Ap_sel

				3) SpPatientsdb_sele

				4) SpDoctorsdb_Ap_sel

				5) SpPatientApt_sel


Creator:		Mr.Khilesh Tembhurnikar

Purpose: 		
Functionality:	
Created:		Mr.Khilesh Tembhurnikar
Applications:	

Comments:		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Example:		
         SELECT * FROM Patients
         SELECT * FROM Doctors
         SELECT * FROM Appointments


		 EXECUTE SpPatientsdb_sel 'INSERT',1011, 'Sakshi', 'Vasvani', 22, 'Female', 938574514;

		 EXECUTE Sp_Patientsdb_Ap_sel 'INSERT',1005,5,106,'2023-11-25','14:15:00','Knee pain';

		 EXECUTE SpPatientsdb_sele 22,35

		 EXECUTE SpDoctorsdb_Ap_sel 'UPDATE',104,'333-111-444';

		 EXECUTE SpPatientApt_sel 'DELETE','2023-11-10';
                   
Modifications:

Date           Developer                         Description
----------  --------------	--------------------------------------------------------------------------------------------------------------------
07/11/2023    Khilesh Tembhurnikar               Create a multiple procedure with query
*/
--------------------------------------------------------------------------------------------------------------

/*
select * from Patients
EXECUTE SpPatientsdb_sel 'INSERT',1011, 'Sakshi', 'Vasvani', 22, 'Female', 938574514;
*/
 
CREATE PROCEDURE SpPatientsdb_sel
                                           @action VARCHAR(10),
                                           @PatientID INT,
                                           @FirstName VARCHAR(50),
                                           @LastName VARCHAR(50),
                                           @Age INT,
                                           @Gender VARCHAR(10),
                                           @ContactNumber VARCHAR(15)
                                          
as
BEGIN

    IF @action = 'INSERT' 
	  begin
        -- Insert a new employee
        INSERT INTO Patients (PatientID, FirstName, LastName, Age, Gender,ContactNumber)
        VALUES (@PatientID, @FirstName, @LastName, @Age, @Gender, @ContactNumber)
end
    
END


/*Create a Stored Procedure to Schedule an Appointment:
2] Develop a stored procedure that allows scheduling appointments.
It should accept parameters for patient ID, doctor ID, appointment date,
appointment time, and reason, and inserts a new appointment 
into the Appointments table.*/

/*select * from Appointments
EXECUTE Sp_Patientsdb_Ap_sel 'INSERT',1005,5,106,'2023-11-25','14:15:00','Knee pain';
*/

CREATE PROCEDURE SpPatientsdb_Ap_sel
                                           @action VARCHAR(10),
										   @AppointmentId INT,
                                           @PatientID INT,
                                           @DoctorId INT,
                                           @AppointmentDate DATE,
                                           @AppointmentTime TIME,
                                           @AppointmentReason VARCHAR(100	)
                                        
                                          
as
BEGIN

    IF @action = 'INSERT' 
	  begin
        -- Insert a new employee
        INSERT INTO Appointments (AppointmentId,PatientID,DoctorId,AppointmentDate, AppointmentTime, AppointmentReason)
        VALUES ( @AppointmentId,@PatientID, @DoctorId, @AppointmentDate, @AppointmentTime, @AppointmentReason)
end
    
END


 
/*Create a Stored Procedure to List Patients by Age Range:
3] Design a stored procedure that takes minimum and
   maximum age as input parameters and returns a list of patients within that age range.*/

 /*select * from patients
EXECUTE SpPatientsdb_sele 22,35
*/

Alter PROCEDURE SpPatientsdb_sele        
                                       
                                          @MinimumAge INT,
										  @MaximumAge INT
                                         
                                          
as
BEGIN

select * 
from patients
where Age >=@MinimumAge and Age <= @MaximumAge 

end


 
/*Create a Stored Procedure to Update Doctor Information:
4] Develop a stored procedure that updates a doctor's contact number based on the doctor's ID.*/

/*select * from Doctors
EXECUTE SpDoctorsdb_Ap_sel 'UPDATE',104,'333-111-444';
*/


CREATE PROCEDURE SpDoctorsdb_Ap_sel
                                           @action VARCHAR(10),
                                           @DoctorID INT,
                                           @ContactNumber VARCHAR(15)

as
BEGIN

    IF @action = 'UPDATE' 
	begin
        -- Update an existing employee
        UPDATE Doctors
        SET

            ContactNumber = @ContactNumber      
            WHERE DoctorID = @DoctorID;

end
   
END

/*Create a Stored Procedure to Delete Appointments by Date:
5] Build a stored procedure that accepts an appointment 
   date as a parameter and deletes all appointments that match the specified date.*/
  
  /*select * from Appointments
EXECUTE SpPatientApt_sel 'DELETE','2023-11-10';
*/

   CREATE PROCEDURE SpPatientApt_sel
                                           @action VARCHAR(10),
                                           @AppointmentDate DATE
                                           
as
BEGIN


    if @action = 'DELETE'
	begin
        -- Delete an employee
        DELETE FROM Appointments
        WHERE AppointmentDate =   @AppointmentDate;

		end

    
END












/*********************************************************************************************************/
                       --                   ALL THE BEST                --
/*********************************************************************************************************/

