SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================================================================================
-- Author: Ashish Gaikwad
-- Create date: <Create Date,,>
-- Description:	<Description,,>    
/*                                                      
                                                 exec  [Sp_TD_Customer_Mod] @CustCode = 'C00036', 
								                         			        @CustName = 'Sam',
								                         			        @City     = 'SanFransisCo',
								                         			        @WorkingArea = 'Manhatten',
								                         			        @CoustomerCountry = 'USA',
								                         			        @Grade = 10,  
                                                         			        @PhoneNo= '5689986589',
 								                         			        @AgentCode = 'A008'

                                                       
select * from  CustomerUniqueData  order by 1 desc                                
-- =======================================================================================================================================*/
ALTER PROCEDURE [Sp_TD_Customer_Mod]  @CustCode varchar(10) ,                  
									   @CustName varchar(20),        
									   @City varchar(30),            
									   @WorkingArea varchar(30),     
									   @CoustomerCountry varchar(20),
									   @Grade int,           
									   @PhoneNo varchar(17),         
	           						   @AgentCode varchar(10)        
	
AS
BEGIN	
	SET NOCOUNT ON;

/* Inserting data into CustomerUniqueData if not matched by source */
merge  CustomerUniqueData
using  (	select CustomerCode    = @CustCode,      
				   CustomerName	   = @CustName,        
                   CustomerCity	   = @City,              
                   WorkPlace       = @WorkingArea,       
                   Country         = @CoustomerCountry, 
                   CustomerGrade   = @Grade,             
                   CustomerPhoneNo = @PhoneNo,          
                   AgentCode       = @AgentCode	)as tmpCustomer on tmpCustomer.CUstomerCode = CustomerUniqueData.CustCode     

    
when not matched then
     insert (	CustCode,
				CustName,	
				City,	
				WorkingArea,	
				CoustomerCountry,	
				Grade,	
				PhoneNo,	
				AgentCode	)
      
     values (	tmpCustomer.CustomerCode,
				tmpCustomer.CustomerName,
				tmpCustomer.CustomerCity,
				tmpCustomer.WorkPlace,
				tmpCustomer.Country,
				tmpCustomer.CustomerGrade,
				tmpCustomer.CustomerPhoneNo,
				tmpCustomer.AgentCode	)

when matched and concat(CustomerUniqueData.CustName, ';', CustomerUniqueData.City, ';', CustomerUniqueData.WorkingArea, ';', CustomerUniqueData.CoustomerCountry, ';', CustomerUniqueData.Grade, ';', CustomerUniqueData.PhoneNo, ';', CustomerUniqueData.AgentCode, ';' ) 
              != concat(tmpCustomer.CustomerName, ';', tmpCustomer.CustomerCity, ';', tmpCustomer.WorkPlace, ';', tmpCustomer.Country, ';', tmpCustomer.CustomerGrade, ';', tmpCustomer.CustomerPhoneNo, ';', tmpCustomer.AgentCode) then
	 update
	 set    CustomerUniqueData.CustName         = tmpCustomer.CustomerName,
	        CustomerUniqueData.City             = tmpCustomer.CustomerCity,
			CustomerUniqueData.WorkingArea      = tmpCustomer.WorkPlace,
			CustomerUniqueData.CoustomerCountry = tmpCustomer.Country,
			CustomerUniqueData.Grade            = tmpCustomer.CustomerGrade,
			CustomerUniqueData.PhoneNo          = tmpCustomer.CustomerPhoneNo,
            CustomerUniqueData.AgentCode        = tmpCustomer.AgentCode;

END
GO
