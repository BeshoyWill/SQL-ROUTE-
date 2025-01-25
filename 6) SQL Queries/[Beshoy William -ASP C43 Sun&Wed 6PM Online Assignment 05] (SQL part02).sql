Use MyCompany

--* 1.	For each project, list the project name and the total hours per week (for all employees) spent on that project.
SELECT P.Pname, SUM(W.Hours * 7) as [Total Hours per Week] FROM Project P JOIN Works_for W ON P.Pnumber=W.Pno group by P.Pname


--* 2.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT D.Dname, MAX(E.Salary) as [Maximum Salary], MIN(E.Salary) as [Minimum Salary], AVG(E.Salary) as [Average Salary] FROM Departments D JOIN Employee E on E.Dno=D.Dnum GROUP BY D.Dname


--* 3.	Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT * FROM Departments D JOIN Employee E ON E.Dno=D.Dnum WHERE E.SSN = (SELECT MIN(E.SSN) FROM Employee E);


--* 4.	List the last name of all managers who have no dependents
SELECT E.Lname FROM Employee E JOIN Dependent D ON D.ESSN=E.SSN WHERE D.Dependent_name IS NULL


--* 5.	For each department-- if its average salary is less than the average salary of all employees display its number, name and number of its employees.
SELECT D.Dnum, D.Dname, COUNT(E.SSN) AS [number of employees] FROM Departments D JOIN Employee E ON E.Dno=D.Dnum GROUP BY D.Dnum, D.Dname HAVING AVG(E.Salary) < (SELECT AVG(E.Salary) FROM Employee E);

--* 6.	Try to get the max 2 salaries using subquery.
SELECT E.Salary FROM Employee E WHERE E.Salary IN (
	SELECT DISTINCT TOP 2 (E.Salary) FROM Employee E
) ORDER BY E.Salary DESC

-- ANOTHER SOLUTION >>>
SELECT TOP 2 (E.Salary) FROM Employee E ORDER BY E.Salary DESC


--* 7.	Display the employee number and name if he/she has at least one dependent (use exists keyword) self-study.
SELECT E.SSN, E.Fname + ' ' + E.Lname AS [Full Name] FROM Employee E WHERE EXISTS (
	SELECT 1 FROM Dependent D WHERE D.ESSN=E.SSN
)