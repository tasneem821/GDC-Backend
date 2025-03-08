SELECT * FROM Departments
Select * from Countries
select * from Employees
--Count the number of employees are there in the employees table
SElECT Count(*) AS 'Number Of Empolyees'
FROM Employees EMP

--Count the number of employees in each department 
SElECT Dept.Name AS 'Department Name',Count(EMP.ID) AS 'Number Of Empolyees In Each Department' 
FROM Employees EMP INNER JOIN Departments Dept 
ON EMP.DepartmentID = Dept.ID
GROUP BY (Dept.Name)

--How many employees have a recorded BonusPerc value?
SElECT Count(EMP.BonusPerc) AS 'Number Of Empolyees have Bonus value'
FROM Employees EMP

--What is the total salary paid to all employees?
SElECT SUM(EMP.MonthlySalary) AS 'Total Salary of Employees'
FROM Employees EMP


--Calculate the total salary for each department 

SElECT Dept.Name AS 'Department Name',SUM(EMP.MonthlySalary) AS 'Total Salary of Employees'
FROM Employees EMP INNER JOIN Departments Dept 
ON EMP.DepartmentID = Dept.ID
GROUP BY (Dept.Name)

--What is the average salary of employees ?
SElECT AVG(EMP.MonthlySalary) AS 'Average Salary of Employees'
FROM Employees EMP

--Find the country with the shortest Name in the Countries table.
SElECT TOP 1 c.Name AS 'country Name',MIN(len(c.Name)) AS 'shortest len'
FROM Countries c
GROUP BY c.Name
ORDER BY len(c.Name)

--Find the number of departments operating in each country.

SElECT c.Name AS 'countryName', COUNT(Dept.ID)AS 'number of departments operating'
FROM Countries c INNER JOIN  Employees EMP
ON EMP.CountryID = c.ID
INNER JOIN Departments Dept
ON EMP.DepartmentID = Dept.ID 
GROUP BY (c.Name)

--What is the average salary for each department?

SElECT Dept.Name AS 'Department Name',AVG(EMP.MonthlySalary) AS 'avrage Salary of Employees'
FROM Employees EMP INNER JOIN Departments Dept 
ON EMP.DepartmentID = Dept.ID
GROUP BY (Dept.Name)

--Find the lowest salary in the employees table
SElECT MIN(EMP.MonthlySalary) AS 'lowest salary'
FROM Employees EMP


--Which department has the lowest average salary?
SElECT TOP 1 Dept.Name AS 'Department Name',AVG((EMP.MonthlySalary)) AS 'avrage Salary of Employees'
FROM Employees EMP INNER JOIN Departments Dept 
ON EMP.DepartmentID = Dept.ID
GROUP BY (Dept.Name)
ORDER BY AVG((EMP.MonthlySalary)) ASC

--Find the highest salary in the employees table
SElECT MAX(EMP.MonthlySalary) AS 'highest salary'
FROM Employees EMP


--Which department has the highest total salary?
SElECT TOP 1 Dept.Name AS 'Department Name',SUM((EMP.MonthlySalary)) AS 'highest total salary in department'
FROM Employees EMP INNER JOIN Departments Dept 
ON EMP.DepartmentID = Dept.ID
GROUP BY (Dept.Name)
ORDER BY SUM((EMP.MonthlySalary)) DESC

--Find the number of employees hired in each country per year.
SElECT c.Name AS 'countryName',YEAR(EMP.HireDate) AS 'hired Year', COUNT(EMP.ID)AS 'number of empolyess hired'
FROM Countries c INNER JOIN  Employees EMP
ON EMP.CountryID = c.ID
GROUP BY (c.Name),(YEAR(EMP.HireDate))
ORDER BY c.Name,YEAR(EMP.HireDate)

--Find the number of employees who have an ExitDate in each country.
SElECT c.Name AS 'countryName', COUNT(EMP.ExitDate)AS 'number of empolyess in exitdate'
FROM Countries c INNER JOIN  Employees EMP
ON EMP.CountryID = c.ID
GROUP BY (c.Name)

--Write a query to select all countries from the Countries table, replacing NULL values in the Name column with 'Unknown' using

SELECT ISNULL( c.Name,'Unknown') AS 'countryName'
FROM Countries c

--Write a query to select employee ID and ExitDate from the Employees table. If ExitDate is NULL, replace it with 'Still Employed'
SELECT Emp.ID,ISNULL( CAST(Emp.ExitDate AS VARCHAR(100)),'Still Employed') AS 'Exit Date'
FROM Employees Emp

--Write a query to display ID, FirstName, and MonthlySalary from the Employees table. If MonthlySalary is NULL, replace it with 0
SELECT Emp.ID,ISNULL( CAST(Emp.MonthlySalary AS VARCHAR(100)),'0') AS 'Monthly Salary'
FROM Employees Emp

--Write a query to display employee ID, FirstName, and BonusPerc. If BonusPerc is NULL, replace it with 5.0

SELECT Emp.ID,Emp.FirstName,ISNULL(Emp.BonusPerc,5.0) AS 'BonusPerc'
FROM Employees Emp

--Write a query to convert the HireDate in the Employees table to VARCHAR(20) format 
SELECT Emp.ID,Emp.FirstName,CONVERT(VARCHAR(20),Emp.HireDate) AS 'Hire Date'
FROM Employees Emp

--Write a query to cast the BonusPerc column in the Employees table to an INTEGER 
SELECT Emp.ID,Emp.FirstName ,CAST(ISNULL(Emp.BonusPerc, 0) AS INT) AS Bonus_Perc
FROM Employees Emp


--Write a query to cast the CountryID column from the Employees table to NVARCHAR(10)


SELECT Emp.ID,Emp.FirstName ,CAST(ISNULL(Emp.CountryID, 0) AS NVARCHAR(10)) AS 'CountryID'
FROM Employees Emp

--Write a query to convert the HireDate to a specific format 'YYYY-MM-DD'
SELECT Emp.ID,Emp.FirstName ,FORMAT(Emp.HireDate ,'yyyy-MM-dd') AS 'hireDate'
FROM Employees Emp

--Write a query to format the HireDate column in the Employees table as 'Month Day, Year' (e.g., March 5, 2025)
SELECT Emp.ID,Emp.FirstName ,FORMAT(Emp.HireDate ,'MMMM dd, yyyy') AS 'hireDate'
FROM Employees Emp

--Write a query to format the MonthlySalary column in the Employees table as a currency (e.g., 1,500.00 format)
SELECT Emp.ID,Emp.FirstName ,FORMAT(Emp.MonthlySalary ,'C') AS 'monthlySalary'
FROM Employees Emp

--Write a query to format the ExitDate in the Employees table to display only the year
SELECT Emp.ID,Emp.FirstName ,ISNULL(FORMAT(Emp.ExitDate ,'yyyy'),'Still Employed') AS 'ExitDate'
FROM Employees Emp

--Write a query to format the BonusPerc column to display a percentage (e.g., 5% instead of 0.05)
SELECT Emp.ID,Emp.FirstName ,FORMAT(Emp.BonusPerc ,'P') AS 'BonusPerc'
FROM Employees Emp

--Write a query to get the current system date and time using a SQL function.

SELECT GETDATE()

--Write a query to calculate the age of each employee based on their DateOfBirth column
ALTER TABLE Employees
ADD Age INT;

UPDATE Employees
SET  Age = DATEDIFF(YEAR,Employees.DateOfBirth,GETDATE())
SELECT *
FROM Employees EMP 


--Write a query to extract the year from the HireDate column in the Employees table.
SELECT Emp.ID,Emp.FirstName ,FORMAT(Emp.HireDate ,'yyyy') AS 'Hire Year'
FROM Employees Emp

--Write a query to find the difference in days between HireDate and ExitDate for employees who have an ExitDate.

SELECT Emp.ID,Emp.FirstName ,DAY(Emp.ExitDate)-DAY(Emp.HireDate) AS 'difference days'
FROM Employees Emp
WHERE Emp.ExitDate IS NOT NULL
--another sol
SELECT Emp.ID,Emp.FirstName ,DATEDIFF(DAY,Emp.HireDate,Emp.ExitDate) AS 'difference days'
FROM Employees Emp
WHERE Emp.ExitDate IS NOT NULL

--Write a query to add 6 months to the HireDate of each employee using a DateTime function.
SELECT Emp.ID,Emp.FirstName ,MONTH(Emp.HireDate)+6 AS 'Month + 6'
FROM Employees Emp

--Write a query to return the length of each employee's FirstName.
SELECT Emp.ID,Emp.FirstName ,LEN(Emp.FirstName) AS 'lenght of first Name'
FROM Employees Emp

--Write a query to convert all employee LastNames to uppercase using a string function.
SELECT Emp.ID,UPPER(Emp.LastName) AS 'last Name'
FROM Employees Emp

--Write a query to extract the first three characters of each country’s Name column in the Countries table.
SELECT SUBSTRING(c.Name,1,3) AS 'first 3 char'
FROM Countries c

--Write a query to replace occurrences of the letter 'a' with '@' in the FirstName column.
SELECT Emp.ID,REPLACE(Emp.FirstName,'a','@') AS 'first Name'
FROM Employees Emp


--Write a query to check if an employee’s LastName contains the substring 'son' using a string function
SELECT Emp.ID,Emp.LastName 
FROM Employees Emp
WHERE Emp.LastName LIKE '%son%'

--Write a query to calculate the logarithm (base 10) of the MonthlySalary column in the Employees table.
SELECT Emp.ID,LOG10(Emp.MonthlySalary)AS 'salary LOG 10'
FROM Employees Emp

--Write a query to compute the sine of each employee’s BonusPerc value.
SELECT Emp.ID,SIN(Emp.BonusPerc)AS 'Sin precBonus'
FROM Employees Emp

--Write a query to return the absolute difference between MonthlySalary and BonusPerc.
SELECT Emp.ID,ABS(EMP.MonthlySalary-Emp.BonusPerc)AS 'absoulte difference salary and bonus'
FROM Employees Emp

--Write a query to generate a random number between 1 and 100 for each employee .

SELECT Emp.ID , Emp.FirstName , FLOOR (RAND()*100) AS 'Random Num'
FROM Employees Emp