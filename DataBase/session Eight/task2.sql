ALTER TABLE Departments
ADD currentHeadcount INT DEFAULT 0

CREATE TRIGGER TR_UpdateHeadcount
ON Employees
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        RAISERROR('Deleting employees is not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE D
        SET CurrentHeadcount = (
            SELECT COUNT(*)
            FROM Employees E
            WHERE E.DepartmentID = D.ID
              AND E.ExitDate IS NULL
        )
        FROM Departments D
        WHERE D.ID IN (
            SELECT DISTINCT DepartmentID
            FROM inserted
        );
    END;
END;


INSERT INTO Employees (FirstName, LastName, Gendor, DateOfBirth, CountryID, DepartmentID, HireDate, ExitDate, MonthlySalary, BonusPerc, Age)
VALUES ('John', 'Doe', 'M', '1990-01-01', 1, 1, '2023-10-01', NULL, 5000.00, 10.0, 33);
UPDATE Employees
SET ExitDate = GETDATE()
WHERE ID = 1001
DELETE FROM Employees
WHERE ID = 1001;

SELECT * FROM Employees