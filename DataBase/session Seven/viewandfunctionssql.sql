

/*
Create a new table named TopInstrctors with the following columns:
✓ InstructorId
✓ InstructorName
✓ DepartmentID
✓ Salary
➢ Write a query to insert records into TopInstrctors for Instructors who have a
Salary greater than 100000
*/
CREATE TABLE TopInstructors(
InstructorId INT PRIMARY KEY,
InsturctorName VARCHAR(20),
DepartmentId INT NOT NULL,
Salary FLOAT);



INSERT INTO TopInstructors (InstructorId,InsturctorName,DepartmentId,Salary)
SELECT Instructor.Ins_Id,Instructor.Ins_Name,Instructor.Dept_Id,Instructor.Salary FROM ITI.dbo.Instructor

SELECT * FROM TopInstructors



--create [NewDepartment] table copied from Department table
SELECT * INTO NewDepartment
FROM ITI.dbo.Department


--Create [NewDeptWithStructureOnly] table and its structure from Department table
SELECT * INTO NewDeptWithStructureOnly
FROM ITI.dbo.Department
WHERE 1 = 2



/*

. Create Function Named [GetConcatenation] that takes string1, string2 as inputs
and return new Concatenation String of string1 & string2, Note : use CONCAT
Function and Mention The Type Of Function
Example : GetConcatenation(‘Ahmed’, ‘Refat’) => Ahmed Refat
*/
CREATE FUNCTION GetConcatenation(@F_Name VARCHAR(20),@L_Name VARCHAR(20))
RETURNS VARCHAR(30)


BEGIN
DECLARE @Full_Name VARCHAR(30)

SET @Full_Name = CONCAT(@F_Name,' ',@L_Name)
RETURN @Full_Name



END

SELECT dbo.GetConcatenation('Tasneem','Gomaa') AS FullName;


/*
5. Create Function [GetTop5GradesAndItsStudentsNames] that take no parameters
and return Top 5 Grades and Student First Name of this Grade,
And mention The Type of this Function
- Note: Use Student & StudnetCourse Tables
*/
CREATE FUNCTION GetTop5GradesAndItsStudentsNames()
RETURNS TABLE
AS 
RETURN(
SELECT TOP(5) student.St_Fname AS 'studentFirstName',Stud_Course.Grade AS 'Student Grade'
FROM student
INNER JOIN Stud_Course
ON student.St_Id=Stud_Course.St_Id
ORDER BY Stud_Course.Grade DESC

)

SELECT * FROM ITI.dbo.GetTop5GradesAndItsStudentsNames()

/*
Create Function Named [BounsForMangersOnly] that take InstructorID
• If this Instructor is manger of Any Department
return its Name, DepartmentName that he mange, Salary, SalaryWithBounce
- SalaryWithBounce = Salary +( salary * 0.1)
• Else => return its Name only
• Do it Using Inline Table Function and MultiStatment Table Function
➢ You have to add mangers [Instructors] for each Department to solve and test this Question

*/

CREATE FUNCTION BounsForMangersOnly(@ins_ID INT)
RETURNS @T TABLE
(
instructorName VARCHAR(20),
DepartmentName VARCHAR(20),
Salary FLOAT,
SalaryWithBonus FLOAT

)
AS
BEGIN
DECLARE @Manager BIT=0;

IF EXISTS(SELECT 1 FROM Department WHERE Dept_Manager = @ins_ID)
BEGIN
SET @Manager = 1

END




IF @Manager=1
BEGIN 
INSERT INTO @T
SELECT i.Ins_Name,d.Dept_Name,i.Salary,(i.Salary+(i.Salary*0.1))
FROM Instructor i
INNER JOIN 
Department d
ON i.Ins_Id = d.Dept_Manager
WHERE i.Ins_Id = @ins_ID

END
ELSE 
BEGIN 
INSERT INTO @T
SELECT i.Ins_Name,
   NULL AS DepartmentName, 
            NULL AS Salary, 
            NULL AS SalaryWithBonus
FROM Instructor i

WHERE i.Ins_Id = @ins_ID

END
RETURN

END

SELECT * FROM ITI.dbo.BounsForMangersOnly(4)


CREATE FUNCTION BounsForMangersOnly_Inline(@insID INT)
RETURNS TABLE
AS
RETURN(
    SELECT 
        i.Ins_Name,
        d.Dept_Name,
        i.Salary,
        (i.Salary + (i.Salary * 0.1)) AS SalaryWithBounce
    FROM 
        Instructor i
    LEFT JOIN 
        Department d ON i.Ins_Id = d.Dept_Manager
    WHERE 
        i.Ins_Id = @insID
        AND d.Dept_Manager IS NOT NULL
    UNION ALL
    SELECT 
        i.Ins_Name,
        NULL AS DepartmentName,
        NULL AS Salary,
        NULL AS SalaryWithBounce
    FROM 
        Instructor i
    LEFT JOIN 
        Department d ON i.Ins_Id = d.Dept_Manager
    WHERE 
        i.Ins_Id = @insID
        AND d.Dept_Manager IS NULL
)

SELECT * FROM Iti.dbo.BounsForMangersOnly_Inline(2)

/*
What is a View?

A view in SQL is a virtual table that is based on the result set of a SELECT query. Unlike a physical table, a view does not store data itself. Instead, it dynamically retrieves data from one or more underlying tables (or other views) whenever it is queried
Why Do We Use Views?
1. Simplify Complex Queries
2. Restrict Access to Sensitive Data
3. Provide a Consistent Interface
*/
/*

 What are The Types of View
 1. Simple View

    A simple view is based on a single table and does not involve complex operations like joins, aggregations, or subqueries

2. Partitioned View

    A partitioned view combines data from multiple tables (often with similar structures) into a single logical view.

    It is commonly used in distributed databases or when data is partitioned across multiple tables
*/


/*
If We need to Create View that Select Departments Names and all Grades in the ITI
database What Is The type of this View, we think about? Then Create this View

standard view as it have1 select
*/
CREATE VIEW DeptwithGrades
AS
SELECT d.Dept_Name , stc.Grade
FROM Student s
INNER JOIN Stud_Course stc
ON s.St_Id = stc.St_Id
INNER JOIN Department d
ON s.Dept_Id = d.Dept_Id


SELECT * FROM DeptwithGrades


/*10.Create an Encrypted view that displays manager names and the topics they teach.*/
--how you want me to connect to topic and there is no key that will make me reach it 



/*11.Create a view that displays the student's full name and course name if the student
has a grade more than 50.*/

CREATE VIEW studentGrades
AS
SELECT s.St_Fname + ' '+ s.St_Lname AS 'fullName' , stc.Grade
FROM Student s
INNER JOIN Stud_Course stc
ON s.St_Id = stc.St_Id
WHERE stc.Grade>50

SELECT * FROM studentGrades


/*12.Create a multi-statements table-valued function that takes 2 integers and returns
the values between them.*/
CREATE FUNCTION getNumbersInRanges(@start INT,@end INT)
RETURNS @T TABLE(Value INT)
AS
BEGIN
IF @start > @end 
BEGIN 
DECLARE @temp INT
SET @temp = @start
SET @start = @end
SET @end = @temp
END

WHILE @start <= @end
BEGIN
INSERT INTO @T (Value)
VALUES(@start)

SET @start = @start + 1

END
RETURN
END

SELECT * FROM ITI.dbo.getNumbersInRanges(2,10);
/*Create a scalar function that takes Student ID and returns a message to user
a. If first name and Last name are null then display 'First name & last name are null'
b. If First name is null then display 'first name is null'
c. If Last name is null then display 'last name is null'
d. Else display 'First name & last name are not null'*/


CREATE FUNCTION studentName(@StID INT)
RETURNS VARCHAR(50)
BEGIN
DECLARE @Ans VARCHAR(50)
DECLARE @FName VARCHAR(20)
DECLARE @LName VARCHAR(20)
SELECT @Fname=s.St_Fname ,@LName = s.St_Lname
FROM Student s
WHERE s.St_Id = @StID

IF @FName IS NULL AND @LName IS NULL 
BEGIN 
SET @Ans = 'First name & last name are null'
END
ELSE IF @FName IS NULL AND @LName IS NOT NULL
BEGIN 
SET @Ans = 'first name is null'
END 
ELSE IF @FName IS NOT NULL AND @LName IS NULL
BEGIN 
SET @Ans = 'last name is null'
END 
ELSE 
BEGIN 
SET @Ans = 'First name & last name are not null'
END 

RETURN @Ans

END

SELECT dbo.studentName(2) AS 'condition of Name'
















