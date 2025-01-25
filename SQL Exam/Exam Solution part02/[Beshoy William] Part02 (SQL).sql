USE Library

--1. Write a query that displays Full name of an employee who has more than 3 letters in his/her First Name.{1 Point} 
SELECT CONCAT(E.Fname, ' ', E.Lname)
FROM Employee E
WHERE LEN(E.Fname) > 3


--2. Write a query to display the total number of Programming books 
-- available in the library with alias name ‘NO OF PROGRAMMING 
-- BOOKS’ {1 Point} 
SELECT COUNT(C.Id) AS [NO OF PROGRAMMING BOOKS]
FROM Book B JOIN Category C ON B.Cat_id = C.Id
WHERE C.Cat_name='Programming'


--3. Write a query to display the number of books published by 
-- (HarperCollins) with the alias name 'NO_OF_BOOKS'. {1 Point}
SELECT COUNT(P.Id) AS [NO_OF_BOOKS]
FROM Publisher P
WHERE P.Name='HarperCollins'

--4. Write a query to display the User SSN and name, date of borrowing and due date 
-- of the User whose due date is before July 2022. {1 Point}
SELECT U.SSN, U.User_Name, B.Borrow_date, B.Due_date
FROM Users U 
JOIN Borrowing B ON U.SSN = B.User_ssn
WHERE B.Due_date < '2022-07-01'

--5. Write a query to display book title, author name and display in the 
-- following format, ' [Book Title] is written by [Author Name]. {2 Points}
SELECT B.Title [Book Title], A.Name AS [Author Name]
FROM Book B
JOIN Book_Author BA ON BA.Book_id=B.Id
JOIN Author A ON BA.Author_id=A.Id

--6. Write a query to display the name of users who have letter 'A' in their names. {1 Point} 
SELECT U.User_Name
FROM Users U
WHERE U.User_Name LIKE '%A%'

--7. Write a query that display user SSN who makes the most borrowing{2 Points} 
SELECT TOP 1 U.SSN
FROM Users U
JOIN Borrowing B ON B.User_ssn = U.SSN
GROUP BY U.SSN
ORDER BY SUM(B.Amount) DESC;

-- 8. Write a query that displays the total amount of money that each user paid for borrowing books. {2 Points}
SELECT U.SSN, U.User_Name, SUM(B.Amount) AS TotalAmountOfMoney
FROM Users U
JOIN Borrowing B ON B.User_ssn=U.SSN
GROUP BY U.SSN, U.User_Name

-- 9. write a query that displays the category which has the book that has the minimum amount of money for borrowing. {2 Points}
SELECT TOP 1 C.Cat_name
FROM Book B
JOIN Borrowing BO ON BO.Book_id = B.Id
JOIN Category C ON C.Id = B.Cat_id
GROUP BY C.Cat_name
ORDER BY SUM(BO.Amount) ASC;


-- 10.write a query that displays the email of an employee if it's not found, 
-- display address if it's not found, display date of birthday. {1 Point} 
SELECT COALESCE(E.Email, E.Address, CONVERT(VARCHAR, E.DOB, 120)) AS [Employee_Info]
FROM Employee E;

-- 11. Write a query to list the category and number of books in each category 
-- with the alias name 'Count Of Books'. {1 Point} 
SELECT C.Id, C.Cat_name, COUNT(B.Id) AS [Count Of Books]
FROM Category C
JOIN Book B ON B.Cat_id=C.Id
GROUP BY C.Id, C.Cat_name
 
-- 12. Write a query that display books id which is not found in floor num = 1 and shelf-code = A1.{2 Points} 
SELECT B.Id
FROM Book B
JOIN Shelf S ON S.Code = B.Shelf_code
JOIN Floor F ON F.Number=S.Floor_num
WHERE NOT (F.Number=1 AND S.Code='A1')

-- 13.Write a query that displays the floor number , Number of Blocks and 
-- number of employees working on that floor.{2 Points}
SELECT F.Number, F.Num_blocks, COUNT(E.Id) AS [number of employees working on that floor]
FROM Floor F
JOIN Employee E ON E.Floor_no = F.Number
GROUP BY F.Number, F.Num_blocks

-- 14.Display Book Title and User Name to designate Borrowing that occurred 
-- within the period ‘3/1/2022’ and ‘10/1/2022’.{2 Points}
SELECT B.Title, U.User_Name
FROM Book B
JOIN Borrowing BO ON BO.Book_id = B.Id
JOIN Users U ON U.SSN = BO.User_ssn
WHERE BO.Borrow_date BETWEEN '2022-03-01' AND '2022-10-01';

-- 15.Display Employee Full Name and Name Of his/her Supervisor as 
-- Supervisor Name.{2 Points}
SELECT CONCAT(E.Fname, ' ', E.Lname) AS [EmployeeName], CONCAT(S.Fname, ' ', S.Lname) AS [SupervisorName]
FROM Employee E
JOIN Employee S ON E.Super_id=S.Super_id

-- 16.Select Employee name and his/her salary but if there is no salary display 
-- Employee bonus. {2 Points} 
SELECT CONCAT(E.Fname, ' ', E.Lname) AS [Employee Name],  COALESCE(E.Salary, E.Bouns) AS [Employee_Income]
FROM Employee E

-- 17.Display max and min salary for Employees {2 Points}
SELECT MIN(E.Salary) AS [Minimum Salary], MAX(E.Salary) [Maximum Salary]
FROM Employee E

-- 18.Write a function that take Number and display if it is even or odd {2 Points}
GO
CREATE OR ALTER FUNCTION CheckEvenOrOdd(@Number INT)
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @N NVARCHAR(20);
	IF @Number % 2 = 0
		RETURN 'Even';
	ELSE
		RETURN 'Odd';
	RETURN @N;
END;

-- This is made for me to check last process
GO
SELECT dbo.CheckEvenOrOdd(4);
SELECT dbo.CheckEvenOrOdd(5);

-- 19.write a function that take category name and display Title of books in that category {2 Points}
GO
CREATE OR ALTER FUNCTION ShowBookTitle(@C_Name NVARCHAR(100))
RETURNS TABLE
AS
RETURN
(
	SELECT B.Title
	FROM Book B
	JOIN Category C ON B.Cat_id = C.Id
	WHERE C.Cat_name = @C_Name
)

-- This is made for me to check last process
GO
SELECT * FROM ShowBookTitle('programming')

-- 20. write a function that takes the phone of the user and displays Book Title , 
-- user-name,  amount of money and due-date. {2 Points}
GO
CREATE OR ALTER FUNCTION GetUserPhone(@UserPhone varchar(11))
RETURNS TABLE
AS
RETURN
(
	SELECT B.Title, U.User_Name, BO.Amount, BO.Due_date
	FROM Users U
	JOIN Borrowing BO ON BO.User_ssn = U.SSN
	JOIN Book B ON B.Id = BO.Book_id
	JOIN User_phones UP ON UP.User_ssn = U.SSN
	WHERE UP.Phone_num = @UserPhone
);

-- This is made for me to check last process
GO
SELECT * FROM GetUserPhone('0123654122')


-- 21.Write a function that take user name and check if it's duplicated 
-- return Message in the following format ([User Name] is Repeated 
-- [Count] times) if it's not duplicated display msg with this format [user 
-- name] is not duplicated,if it's not Found Return [User Name] is Not 
-- Found {2 Points}
GO
CREATE OR ALTER FUNCTION CheckIfDuplicated(@UserName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Count INT;
	SELECT @Count = COUNT(U.SSN)
	FROM Users U
	WHERE U.User_Name = @UserName

	IF @Count > 1
		RETURN @UserName + 'is Repeated ' + CAST(@Count AS VARCHAR(10)) + ' times';
	ELSE IF @Count = 1
        RETURN @UserName + ' is not duplicated';
	ELSE
        RETURN @UserName + ' is Not Found';
	Return @Count
END;

-- This is made for me to check last process
GO
SELECT dbo.CheckIfDuplicated('Amr Ahmed');
SELECT dbo.CheckIfDuplicated('Salma Osama');
SELECT dbo.CheckIfDuplicated('Beshoy William');


-- 22.Create a scalar function that takes date and Format to return Date With 
-- That Format. {2 Points}
GO
CREATE OR ALTER FUNCTION FormatDate(@Input DATE, @Format NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
	RETURN FORMAT(@Input, @Format)
END;

-- This is made for me to check last process
GO
SELECT dbo.FormatDate('2000-05-31', 'MM/dd/yyyy');

-- 23.Create a stored procedure to show the number of books per Category.{2 Points}
GO
CREATE OR ALTER PROCEDURE GetBooksPerCategory
AS
BEGIN
    SELECT C.Cat_Name AS CategoryName, COUNT(B.Id) AS NumberOfBooks
    FROM Category C
    JOIN Book B ON C.Id = B.Cat_Id
    GROUP BY C.Cat_Name
    ORDER BY C.Cat_Name;
END;

-- This is made for me to check last process
GO
EXEC GetBooksPerCategory;

-- 24.Create a stored procedure that will be used in case there is an old manager 
-- who has left the floor and a new one becomes his replacement. The 
-- procedure should take 3 parameters (old Emp.id, new Emp.id and the 
-- floor number) and it will be used to update the floor table. {3 Points} 
GO
CREATE OR ALTER PROCEDURE UpdateFloorManager (@OldEmpId INT, @NewEmpId INT, @FloorNumber INT)
AS
IF EXISTS 
(
	SELECT 1 FROM Floor F WHERE F.Number = @FloorNumber AND F.MG_ID = @OldEmpId
)
BEGIN
	UPDATE Floor
	SET MG_ID = @NewEmpId
	WHERE Floor.Number = @FloorNumber
END

-- This is made for me to check last process
GO
EXEC UpdateFloorManager @OldEmpId = 3, @NewEmpId = 5, @FloorNumber = 1;

-- 25.Create a view AlexAndCairoEmp that displays Employee data for users 
-- who live in Alex or Cairo. {2 Points}
GO
CREATE OR ALTER VIEW AlexAndCairoEmp
AS
SELECT * 
FROM Employee E
WHERE E.Address IN ('Alex', 'Cairo')

-- This is made for me to check last process
GO
SELECT * FROM dbo.AlexAndCairoEmp

-- 26.create a view "V2" That displays number of books per shelf {2 Points}
GO
CREATE OR ALTER VIEW V2
AS
SELECT S.Code, COUNT(B.Id) AS [Number Of Books]
FROM Book B
JOIN Shelf S
ON B.Shelf_code = S.Code
GROUP BY S.Code

-- This is made for me to check last process
GO
SELECT * FROM dbo.V2


-- 27.create a view "V3" That display  the shelf code that have maximum 
-- number of  books using the previous view "V2" {2 Points}
GO
CREATE OR ALTER VIEW V3
AS
SELECT TOP 1 Code, [Number Of Books]
FROM dbo.V2
ORDER BY [Number Of Books] DESC

-- This is made for me to check last process
GO
SELECT * FROM dbo.V3


-- 28.Create a table named ‘ReturnedBooks’ With the Following Structure : 
-- User SSN 
-- Book Id 
-- Due Date 
-- fees 
-- Return 
-- Date 
-- then create A trigger that instead of inserting the data of returned book 
-- checks if the return date is the due date  or not if not so the user must pay 
-- a fee and it will be 20% of the amount that was paid before. {3 Points}
CREATE TABLE ReturnedBooks
(
	[User SSN] INT PRIMARY KEY,
	[Book Id] INT NOT NULL UNIQUE,
	[Due Date] DATE,
	[fees] MONEY,
	[Return Date] DATE,
)

GO
CREATE OR ALTER TRIGGER TR_ReturnedBook
ON ReturnedBooks
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @UserSSN INT, @BookId INT, @DueDate DATE, @Fees MONEY, @ReturnDate DATE, @AmountPaid MONEY;
	SELECT @UserSSN = I.[User SSN], 
           @BookId = I.[Book Id], 
           @DueDate = I.[Due Date], 
           @ReturnDate = I.[Return Date]
    FROM inserted I;

    SELECT @AmountPaid = BO.Amount
    FROM Borrowing BO
    WHERE BO.User_ssn = @UserSSN AND BO.Book_id = @BookId;

    IF @ReturnDate > @DueDate
        SET @Fees = @AmountPaid * 0.2;
    ELSE
        SET @Fees = 0;

    INSERT INTO ReturnedBooks ([User SSN], [Book Id], [Due Date], [fees], [Return Date])
    VALUES (@UserSSN, @BookId, @DueDate, @Fees, @ReturnDate);
END;


-- 29.In the Floor table insert new Floor With Number of blocks 2 , employee 
-- with SSN = 20 as a manager for this Floor,The start date for this manager 
-- is Now. Do what is required if you know that : Mr.Omar Amr(SSN=5) 
-- moved to be the manager of the new Floor (id = 6), and they give Mr. Ali 
-- Mohamed(his SSN =12) His position . {3 Points}
BEGIN TRANSACTION

INSERT INTO Floor (Num_blocks, MG_ID, Hiring_Date)
VALUES (2, 20, GETDATE());

UPDATE Floor
SET MG_ID = 5
WHERE MG_ID = 6

UPDATE Employee
SET Super_id = 5
WHERE Id = 12

COMMIT TRANSACTION


-- 30.Create view name (v_2006_check)  that will display Manager id, Floor 
-- Number where he/she works , Number of Blocks and the Hiring Date 
-- which must be from the first of March and the end of May 2022.this view 
-- will be used to insert data so make sure that the coming new data must 
-- match the condition then try to insert this 2 rows and 
-- Mention What will happen {3 Point} 
-- Employee Id | Floor Number | Number of Blocks | Hiring Date 
-- 2 | 6 | 2 | 7-8-2023 
-- 4 | 7 | 1 | 4-8-2022
GO
CREATE OR ALTER VIEW v_2006_check
AS
SELECT F.MG_ID, F.Number, F.Num_blocks, F.Hiring_Date
FROM Floor F
WHERE F.Hiring_Date BETWEEN '2022-03-01' AND '2022-05-31'

GO
INSERT INTO Floor (MG_ID, Number, Num_blocks, Hiring_Date)
VALUES (2, 6, 2, '2023-07-08')
-- It shows me an error because the Number is Duplicated while it's a primary key which mean that it has unique value

GO
INSERT INTO Floor (MG_ID, Number, Num_blocks, Hiring_Date)
VALUES (4, 7, 1, '2022-04-08')
-- The process worked fine and inserted the given data because the number (8) wasn't already used 

-- 31.Create a trigger to prevent anyone from Modifying or Delete or Insert in 
-- the Employee table ( Display a message for user to tell him that he can’t 
-- take any action with this Table) {3 Point}
GO
CREATE TRIGGER TR_PreventModifyingOnEmployeeTable
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	RAISERROR('You can not take any action with this Table', 16, 1);
	ROLLBACK TRANSACTION;
END


-- 32.Testing Referential Integrity , Mention What Will Happen When: 
-- A. Add a new User Phone Number with User_SSN = 50 in 
-- User_Phones Table {1 Point} 
-- B. Modify the employee id 20 in the employee table to 21 {1 Point} 
-- C. Delete the employee with id 1 {1 Point} 
-- D. Delete the employee with id 12 {1 Point} 
-- E. Create an index on column (Salary) that allows you to cluster the data in table Employee. {1 Point}

-- A :-
GO
INSERT INTO User_phones (User_ssn, Phone_num)
VALUES (50, '01280202342')
-- An error occured because there's no user_ssn = 50

-- B :-
GO
UPDATE Employee 
SET Id = 20
WHERE Id = 21
-- It failed during to primary key restrections

-- C :-
GO
DELETE FROM Employee WHERE Id  = 1
-- It failed because of the references in other tables


-- D :-
GO
DELETE FROM Employee WHERE Id  = 12
-- It failed because of the references in other tables

-- E :-
GO
CREATE CLUSTERED INDEX INDEX_EmployeeSalary 
ON Employee (Salary)
-- It failed during there's a default clustered index for our primary key Employee.Id 


-- 33.Try to Create Login With Your Name And give yourself access Only to 
-- Employee and Floor tables then allow this login to select and insert data 
-- into tables and deny Delete and update (Don't Forget To take screenshot 
-- to every step) {5 Points}
GO
CREATE SCHEMA HR

GO
ALTER SCHEMA HR
TRANSFER [dbo].[Employee]

GO
ALTER SCHEMA HR
TRANSFER [dbo].[Floor]
