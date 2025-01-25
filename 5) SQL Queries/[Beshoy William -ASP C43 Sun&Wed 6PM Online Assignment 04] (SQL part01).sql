use ITI

-- 1.	Get all instructors Names without repetition.
select distinct Ins_Name from Instructor


-- 2.	Display instructor Name and Department Name Note: display all the instructors if they are attached to a department or not.
select I.Ins_Name, D.Dept_Name from Instructor I left join Department D on I.Dept_Id = D.Dept_Id


-- 3.	Display student full name and the name of the course he is taking for only courses which have a grade.
select S.St_Fname + ' ' + S.St_Lname as Full_Name, C.Crs_Name from Student S join Stud_Course SC on S.St_Id = SC.St_Id join Course C on C.Crs_Id = SC.Crs_Id where SC.Grade is not null


-- 4.	Select Student first name and the data of his supervisor.
-- there is no table for supervisor in this databse
select S.St_Fname as firstName from Student S 


-- 5.	Display student with the following Format. Student ID	Student Full Name	Department name
select S.St_Id as [Student ID], S.St_Fname + ' ' + S.St_Lname as [Full Name], D.Dept_Name from Student S join Department D on S.Dept_Id = D.Dept_Id
		
-- @@VERSION	 >>> this displays the version information of the SQL Server.
-- @@SERVERNAME  >>> this retrieves the name of the local SQL Server instance.