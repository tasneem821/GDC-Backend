USE Shop_Database

SELECT * FROM Customers
SELECT * FROM Orders

--Retrieve all possible combinations of customers and orders.


SELECT c.Name,o.OrderID,o.Amount
FROM Customers c CROSS JOIN Orders o

--Get all orders with the customer names.
SELECT c.Name,o.OrderID
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID

--Get all customers, even if they haven’t placed an order.

SELECT c.Name,o.OrderID
FROM Customers c LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID


--Get all orders, even if the customer is missing in the Customers table.
SELECT c.Name,o.OrderID
FROM Customers c RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID


--Get all orders and customers, even if they don’t have a match.

SELECT c.Name,o.OrderID
FROM Customers c FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID

--Find customers who have the same name as another customer (for duplicate detection).
SELECT c.Name,c.CustomerID
FROM Customers c ,Customers Cus
WHERE c.Name = Cus.Name and c.CustomerID != Cus.CustomerID

--Joining Orders, Customers, and an additional Products table.

--Retrieve orders with amounts greater than 500 along with customer names.
SELECT c.Name,o.Amount
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID and o.Amount>500


--Find Customers Without Orders
SELECT c.CustomerID,c.Name
FROM Customers c LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID  
WHERE o.CustomerID IS NULL;


--Count Orders Per Customer
SELECT COUNT(*) as OrderTaken
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID

--Get the Total Amount Spent by Each Customer
SELECT SUM(o.Amount) as totalAmount
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID


--Update Orders Based on Customer Information Increase the amount of all orders placed by "John Doe" by 10%.
UPDATE Orders 
SET Amount += Amount * 0.1
FROM Customers c INNER JOIN Orders o
ON c.CustomerID = o.CustomerID AND c.Name = 'John'


--Delete Orders of Customers Who No Longer Exist
DELETE FROM Orders
WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);