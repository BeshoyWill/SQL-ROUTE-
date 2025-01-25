-- 1.	Display all the employees Data.
select * from Employee

-- 2.	Display the employee First name, last name, Salary and Department number.
select [Fname], [Lname], [Salary], [Dno] from Employee

-- 3.	Display all the projects names, locations and the department which is responsible for it.
select P.[Pname]
      ,P.[Plocation]
      ,D.[Dname]
	  from Project P
	  join Departments D
	  on P.[Dnum] = D.[Dnum]

-- 4.	If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary. Display each employee's full name and his annual commission in an ANNUAL COMM column (alias).
select	(Fname + ' ' + Lname) as [Full Name],
		(salary * 12 * 0.10) as [Annual Comm]
		from Employee

-- 5.	Display the employees Id, name who earns more than 1000 LE monthly.
select 
    [SSN], 
    ([Fname] + ' ' + [Lname]) AS [Full Name] 
from 
	Employee 
where 
    [Salary] > 1000;

-- 6.	Display the employees Id, name who earns more than 10000 LE annually.
select 
    [SSN], 
    ([Fname] + ' ' + [Lname]) AS [Full Name] 
from 
	Employee 
where 
    [Salary] * 12 > 10000;


-- 7.	Display the names and salaries of the female employees 
select  
    ([Fname] + ' ' + [Lname]) AS [Full Name],
	[Salary]
from 
	Employee 
where 
    [Sex] = 'F';


-- 8.	Display each department id, name which is managed by a manager with id equals 968574
select 
	[Dnum] as [Department Id],
	[Dname] as [Department Name]
from Departments
where [MGRSSN] = '968574';


-- 9.	Order the  Employees from the highest salary
select * from Employee order by [Salary] desc;


-- 10.	Display the Projects full data of the projects with a name starting with "a" letter.
select * from Project where [Pname] like 'A%';