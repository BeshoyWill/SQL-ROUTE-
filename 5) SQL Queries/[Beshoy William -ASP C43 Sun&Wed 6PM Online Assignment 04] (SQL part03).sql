use MyCompany

-- DQL:

-- 1.	Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.
select E.*, P.* from Employee E join Departments DP on DP.Dnum=E.Dno join Project P on P.Dnum=DP.Dnum order by DP.Dname, E.Lname, E.Fname


-- 2.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 	
update Employee 
set Salary = Salary * 1.3
from Employee E
join Departments DP on DP.Dnum=E.Dno
join Project P on P.Dnum=DP.Dnum
where P.Pname='Al Rabwah'



-- DML:

-- 1.	In the department table insert a new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'.
insert into Departments (Dnum, Dname, MGRSSN, [MGRStart Date]) values (100, 'DEPT IT', 112233, '1-11-2006')


-- 2.	Do what is required if you know that: Mrs. Oha Mohamed (SSN=968574) moved to be the manager of the new department (id = 100), and they give you (your SSN =102672) her position (Dept. 20 manager) 

	-- a.	First try to update her record in the department table.
	update Departments
	set MGRSSN=968574
	where Dnum=100


	-- b.	Update your record to be department 20 manager.
	update Departments
	set MGRSSN=102672
	from Employee E join Departments D on D.Dnum=E.Dno
	where Dnum=20

	-- c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
	update Employee
	set Superssn=102672
	where Employee.SSN=102660

-- 3.	Unfortunately, the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete him from your database in case you know that you will be temporarily in his position.
update Departments
set MGRSSN = NULL  
where MGRSSN = 223344

delete from Employee
where SSN = 102672;

update Employee
set Superssn=223344
where Superssn=102672
