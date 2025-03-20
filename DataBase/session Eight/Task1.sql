
--task1 
CREATE FUNCTION CalculateDiscount (
@CutomerID INT , @OrderAmount  DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS 
BEGIN
DECLARE @TotalPrevOrders DECIMAL(10,2)
DECLARE @Discount DECIMAL(10,2) = 0.00

SELECT @TotalPrevOrders = ISNULL(SUM(o.Amount),0.00)
FROM Orders o
WHERE o.CustomerID  = @CutomerID

IF (@TotalPrevOrders+@OrderAmount>=1000.00)
BEGIN
SET @Discount = @OrderAmount*0.10
END

RETURN @Discount

END


SELECT Shop_Database.dbo.CalculateDiscount(2,100.00)AS 'Discount'





CREATE PROCEDURE CreateOrder 
@Amount DECIMAL(10,2),
@OrderID INT ,
@CustomerID INT,
@NewOrderID INT OUTPUT
AS
BEGIN
DECLARE @Discount DECIMAL(10,2)
DECLARE @TotalAmount DECIMAL(10,2)
DECLARE @Status INT

IF @Amount < 0
BEGIN
SET @Status = 100
RETURN @Status
END

IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
BEGIN
SET @Status = 150
RETURN @Status
END

SET @Discount = dbo.CalculateDiscount(@CustomerID,@Amount)

SET @TotalAmount = @Amount - @Discount



INSERT INTO Orders (OrderID,CustomerID,Amount)
VALUES(@OrderID , @CustomerID,@Amount)
SET @NewOrderID = SCOPE_IDENTITY();

SELECT * , @Discount AS 'Discount',@TotalAmount AS 'total amount' FROM 
Orders
WHERE OrderID = @NewOrderID

SET @Status = 200
RETURN @Status

END


DECLARE @NewOrderID INT;
DECLARE @Status INT;

EXEC @Status = dbo.CreateOrder
      @OrderID = 101,         
    @Amount = 500.00,        
    @CustomerID = 1,       
    @NewOrderID = @NewOrderID OUTPUT

IF @Status = 200
BEGIN
    PRINT 'Order created successfully. New OrderID: ' + CAST(@NewOrderID AS VARCHAR);
END
ELSE IF @Status = 100
BEGIN
    PRINT 'Error: Invalid order amount.';
END
ELSE IF @Status = 150
BEGIN
    PRINT 'Error: CustomerID does not exist.';
END;


