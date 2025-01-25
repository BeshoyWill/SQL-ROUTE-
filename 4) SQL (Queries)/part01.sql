insert into Employee
(Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values
('Beshoy', 'William', '102672', '1998-01-01', 'Beni Suef, Egypt', 'M', 3000, '112233', 30);

UPDATE Employee
SET 
    [Fname] = 'Ahmed',
    [Lname] = 'Ibrahim',
    [Bdate] = '1995-05-15',
    [Address] = 'Cairo, Egypt',
    [Sex] = 'M',
    [Salary] = NULL,
    [Superssn] = NULL,
    [Dno] = 30
WHERE [SSN] = '223344';

update Employee
set salary = salary * 1.20
where SSN = '102672';

