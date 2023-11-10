/*
Title:			spSample_Employee_Sorting_Paging_sel
Creator:		Ashish Gaikwad	

Purpose: 		Get Employee Details with Sorting and paging
Functionality:	Sample Application

Created:		08/22/2022

Applications:	Demo 

Comments:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Example:		exec spSample_Employee_Sorting_Paging_sel  @Size = 1,
                                                           @Page = 21,                                                          
														   @SortColumn = 'EmpFName',
														   @SortOrder  = 'desc'
                                         
Modifications:

Date        Developer                  Description
----------  -------------------------  ------------------------------------------------------------------------------------------------------------
00/00/0000  Ashish Gaikwad			   
*/

CREATE PROCEDURE  spSample_Employee_Sorting_Paging_sel   @Page         INT = null, 
                                                        @Size         INT = null,
											            @SortColumn   varchar(50)= null,
	                                                    @SortOrder    varchar(5)= null,
														@EmpID        int = null

as
begin


select DepID         = Department.DepartmentID,
       DepName       = Department.DepartmentName,
	   DepCode       = Department.DepartmentCode,
	   EmpID         = Employee.EmployeeID,
	   EmpFName      = Employee.FirstName,
	   EmpLName      = Employee.LastName,
	   DetailHobbies = EmployeeDetails.Hobbies,
	   DetailCity    = EmployeeDetails.City,
	   ROW_NUMBERS   = ROW_NUMBER() over(order by Department.DepartmentID)

from   Department
       inner join Employee on Employee.DepartmentID = Department.DepartmentID
	   left join EmployeeDetails on EmployeeDetails.EmployeeID = Employee.EmployeeID
where  Employee.EmployeeID = @EmpID

order by 
		(case when lower(@SortColumn) = ''         and lower(@SortOrder) = ''     then Employee.EmployeeID end)  desc,
		(case when lower(@SortColumn) = 'EmpFName' and lower(@SortOrder) = 'asc'  then Employee.FirstName end)   asc,
		(case when lower(@SortColumn) = 'EmpFName' and lower(@SortOrder) = 'desc' then Employee.FirstName end)   desc,
		(case when lower(@SortColumn) = 'EmpLName' and lower(@SortOrder) = 'asc'  then Employee.LastName end)    asc,
		(case when lower(@SortColumn) = 'EmpLName' and lower(@SortOrder) = 'desc' then Employee.LastName end)    desc,
		(case when lower(@SortColumn) = 'EmpID'    and lower(@SortOrder) = 'asc'  then Employee.EmployeeID end)  asc,
		(case when lower(@SortColumn) = 'EmpID'    and lower(@SortOrder) = 'desc' then Employee.EmployeeID end)  desc
		
		OFFSET @Page * (@Size - 1) rows
		fetch next  @Page rows ONLY 


end
