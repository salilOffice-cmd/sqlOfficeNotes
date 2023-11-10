with cte as
(
select [app].[udf_stringdecryptor](p.fname) + [app].[udf_stringdecryptor](p.lname) as Patient_Name
       ,p.empi
	   ,pr.project_id
	   ,prj.[name]
	   ,prj.project_type
	   ,mpt.[type_name]
	 
from   app.patient p
       inner join app.patient_to_project pr on pr.patient_empi = p.empi
	   inner join app.project prj on prj.id = pr.project_id
	   inner join app.master_project_types mpt on mpt.id = prj.project_type

)



 
select  cte1.empi,STRING_AGG(cte.[name],',')Comma_Seperate,
        count(cte.[name])count_ofName,
        cte1.Patient_Name,
		cte1.project_id,
		cte1.project_type,
		cte1.[type_name]
      
from   cte as cte1
       join cte on cte1.empi = cte.empi
group by cte1.empi,cte1.Patient_Name,cte1.project_id,cte1.project_type,
		cte1.[type_name]