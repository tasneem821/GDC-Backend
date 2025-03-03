USE HR_DB

--Select all employees

SELECT * FROM Employees;

--Select employees from a specific country (e.g., Egypt - CountryID = 1)

SELECT *
FROM Employees
WHERE CountryID = 1;

--Select employees working in a specific department (e.g., IT - Department ID = 3)
SELECT *
FROM Employees
WHERE DepartmentID = 3;

--Select employees who earn more than 5000
SELECT EMP.FirstName,EMP.LastName,EMP.MonthlySalary
FROM Employees EMP
WHERE EMP.MonthlySalary > 5000;

--Select employees who were hired after 2020


SELECT EMP.FirstName,EMP.LastName,EMP.HireDate
FROM Employees EMP
WHERE EMP.HireDate > '2021';

--Select employees who have exited (i.e., those with an ExitDate set)

SELECT EMP.FirstName,EMP.LastName,EMP.ExitDate
FROM Employees EMP
WHERE EMP.ExitDate is not NULL;

--Select employees with a bonus percentage above 10%
SELECT EMP.FirstName,EMP.LastName,EMP.BonusPerc
FROM Employees EMP
WHERE EMP.BonusPerc > 0.10
