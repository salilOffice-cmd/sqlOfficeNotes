

Create table Patient 
(
  PatientID     int identity,
  PatientName   varchar(50),
  PatientAge    smallint,
  City          varchar(30),
  ZipCode       char(6),
  Phone         int,
  CreatedDate   datetime
)


select *
from  Patient 


insert into Patient 
(
PatientID  
,PatientName
,PatientAge 
,City       
,ZipCode    
,Phone      
,CreatedDate
)

values (1,'Mukesh',30,'Nagpur','456123',78965412,getdate()),
(2,'Suresh',40,'Wardha','569845',6896541,getdate()),
(3,'Ramesh',50,'Nagpur','369852',88965412,getdate()),
(4,'Akhilesh',60,'Nagpur','789654',489654,getdate())



select  PatientID    
       ,PatientName
       ,PatientAge
       ,City
       ,ZipCode       
from   Patient

/***************************************************/
-- where 


select *
from   Patient
where  PatientID = 1


select *
from   Patient
where  PatientName= 'Ramesh'


select *
from   Patient
where  PatientAge =  60



update Patient
set    PatientAge = 60
where  PatientID = 3


