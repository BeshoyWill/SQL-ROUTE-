USE ITI

--* 1.	Retrieve a number of students who have a value in their age. 
SELECT COUNT(*) FROM Student where St_Age IS NOT Null 


--* 2.	Display number of courses for each topic name 
SELECT COUNT(*) AS NumberOfCourses, Top_Name FROM Topic GROUP BY Top_Name;

--* 3.	Display student with the following Format (use isNull function)
SELECT St_Id AS [Student ID], St_Fname + ' ' + St_Lname AS [Full Name], ISNULL(D.Dept_Name, 'No Department') as [Department Name]  FROM Student S JOIN Department D ON S.Dept_Id=D.Dept_Id

--* 4.	Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function” 
SELECT I.Ins_Name, ISNULL(I.Salary, '0000') AS Salary FROM Instructor I 

--* 5.	Select Supervisor first name and the count of students who supervises on them
SELECT Sup.St_Fname as [Supervisor Name], COUNT(Std.St_id) as [Student Count] FROM Student Std join Student Sup on Std.St_super=Sup.St_super group by Sup.St_Fname


--* 6.	Display max and min salary for instructors
SELECT MAX(I.Salary) AS [MAX], MIN(I.Salary) AS [MIN] FROM Instructor I

--* 7.	Select Average Salary for instructors 
SELECT AVG(I.Salary) AS [Average Salary] FROM Instructor I


--* 8.	Display instructors who have salaries less than the average salary of all instructors.
SELECT I.Salary FROM Instructor I WHERE Salary < (SELECT AVG(I.Salary) FROM Instructor I)

--* 9.	Display the Department name that contains the instructor who receives the minimum salary
SELECT D.Dept_Name FROM Department D JOIN Instructor I ON D.Dept_Id=I.Dept_Id WHERE I.Salary = (SELECT MIN(I.Salary) FROM Instructor I)

--* 10.	Select max two salaries in instructor table.
SELECT TOP 2 cast(I.Salary AS int) FROM Instructor I ORDER BY Salary DESC
