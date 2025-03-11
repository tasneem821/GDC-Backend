--Display instructors who have salaries less than the average salary of all instructors

SELECT *
FROM Instructor ins
WHERE ins.Salary < (SELECT AVG(Salary)FROM Instructor)

Select * from Instructor
--Display the Department name that contains the instructor who receives the minimum salary
SELECT Dept.Dept_Name
FROM Department Dept
INNER JOIN Instructor ins
ON Dept.Dept_Id = ins.Dept_Id
WHERE ins.Salary = ( SELECT MIN(Salary) FROM Instructor)


--Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT *
FROM Department Dept
INNER JOIN Instructor ins
ON Dept.Dept_Id = ins.Dept_Id
WHERE ins.Ins_Id = ( SELECT MIN(Ins_Id) FROM Instructor)

--List the last name of all managers who have no dependents



--For each department-- if its average salary is less than the average salary of all employees display its number, name and number of its employees
SELECT  Dept.Dept_Id , Dept.Dept_Name, COUNT(ins.Ins_Id) as 'number of employees'
FROM Department Dept 
INNER JOIN Instructor ins
ON Dept.Dept_Id = ins.Dept_Id
GROUP BY Dept.Dept_Id , Dept.Dept_Name
HAVING AVG(ins.Salary) < (SELECT AVG(Salary)  FROM Instructor )


--Try to get the max 2 salaries using subquery.
SELECT TOP(2) * 
FROM Instructor
ORDER BY Salary DESC


--Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
SELECT * 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Dept_id ORDER BY Salary DESC) AS RN ,ins.Dept_Id, ins.Salary
FROM Instructor ins 
WHERE ins.Salary IS NOT NULL
) as sub
WHERE sub.RN = 1 OR sub.RN =2


-- Write a query to select a random student from each department.  “using one of Ranking Functions”
SELECT * 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY S.Dept_Id ORDER BY RAND() DESC) AS RN ,S.Dept_Id, S.St_Fname
FROM student S  WHERE S.Dept_Id IS NOT NULL ) as sub
WHERE sub.RN = 1 




