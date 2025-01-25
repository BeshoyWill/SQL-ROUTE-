use MyCompany

-- 1.	Display the Department id, name and id and the name of its manager.
select D.Dname, D.Dnum, E.SSN, E.Fname + ' ' + E.Lname as [name] from Departments D join Employee E on D.Dnum = E.Dno

-- 2.	Display the name of the departments and the name of the projects under its control.
select D.Dname, P.Pname from Departments D join Project P on D.Dnum = P.Dnum


-- 3.	Display the full data about all the dependence associated with the name of the employee they depend on.
select * from Dependent D join Employee E on D.ESSN = E.SSN


-- 4.	Display the Id, name, and location of the projects in Cairo or Alex city.
select P.Pnumber, P.Pname, P.Plocation from Project P where P.City in ('Alex', 'Cairo')


-- 5.	Display the Projects full data of the projects with a name starting with "a" letter.
select * from Project P where P.Pname like 'A%'


-- 6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly.
select E.* from Employee E where E.Dno = 30 and E.Salary  between 1000 and 2000


-- 7.	Retrieve the names of all employees in department 10 who work more than or equal 10 hours per week on the "AL Rabwah" project.
select E.Fname + ' ' + E.Lname as [name] from Employee E join Works_for W on E.SSN = W.ESSn join Project P on W.Pno = P.Pnumber where E.Dno = 10 and P.Pname = 'AL Rabwah' and W.Hours >= 10


-- 8.	Find the names of the employees who were directly supervised by Kamel Mohamed.
select E.Fname + ' ' + E.Lname as [Full_Name] from Employee E join Employee Sup on E.SSN = Sup.Superssn where Sup.Fname + ' ' + Sup.Lname = 'Kamel Mohamed'


-- 9.	Display All Data of the managers.
select E.* from Employee E where E.SSN in (select Superssn from Employee where Superssn is not null)


-- 10.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select E.*, P.Pname from Employee E join Departments DP on E.Dno=DP.Dnum  join Project P on DP.Dnum=P.Dnum order by P.Pname


-- 11.	For each project located in Cairo City, find the project number, the controlling department name, the department manager’s last name, address and birthdate.
select P.Pnumber, D.Dname, E.Lname , E.[Address], E.Bdate from Project P join Departments D on D.Dnum=P.Dnum join Employee E on E.SSN=D.MGRSSN where P.City = 'Cairo'

-- 12.	Display All Employees data and the data of their dependents even if they have no dependents.
select E.*, D.* from [Dependent] D right join Employee E on D.ESSN=E.SSN