CREATE DATABASE OnlineShoppingSystem
USE OnlineShoppingSystem

--DDL
--Create Customer table
CREATE TABLE Customer(
ID INT IDENTITY PRIMARY KEY,
Email VARCHAR(100) NOT NULL UNIQUE,
Name NVARCHAR(100) NOT NULL ,
PhoneNumber NVARCHAR(100) NOT NULL ,
Address NVARCHAR(100) NOT NULL
);
--Create Product table
CREATE TABLE Product(
ProductID INT IDENTITY PRIMARY KEY,
Category VARCHAR(100) NOT NULL UNIQUE,
Name NVARCHAR(100) NOT NULL ,
Price DECIMAL(10,2) NOT NULL ,
Description NVARCHAR(100) NOT NULL
);
--Create Supplier table
CREATE TABLE Supplier(
ID INT IDENTITY PRIMARY KEY,
ContactInfo VARCHAR(100) NOT NULL ,
Name NVARCHAR(100) NOT NULL ,

);
--Create Order table
CREATE TABLE ShoppingOrder(
OrderID INT IDENTITY PRIMARY KEY,
totalAmount INT NOT NULL,
OderDate DATETIME DEFAULT GETUTCDATE() ,
Status VARCHAR(100) CHECK(Status IN('Pending','Cancelled','Delivered','Shipping ')),
CustomerID INT NOT NULL ,
FOREIGN KEY(CustomerID ) REFERENCES Customer(ID),
OrderDetailsID INT  UNIQUE NOT NULL,
Quantity INT NOT NULL ,
Price DECIMAL(10,2) NOT NULL
);
--Create Order_Product table
CREATE TABLE Order_Product(
ProductID INT NOT NULL,
FOREIGN KEY(ProductID ) REFERENCES Product(ProductID),
OrderID INT NOT NULL,
FOREIGN KEY(OrderID ) REFERENCES ShoppingOrder(OrderID),

);
--Create Product_ORderDetails table
CREATE TABLE Product_OrderDetails(
ProductID INT NOT NULL,
FOREIGN KEY(ProductID ) REFERENCES Product(ProductID),
OrderDetailsID INT NOT NULL,
FOREIGN KEY(OrderDetailsID ) REFERENCES ShoppingOrder(OrderDetailsID),

);
--Create Product_Supplier table
CREATE TABLE Product_Supplier(
ProductID INT NOT NULL,
FOREIGN KEY(ProductID ) REFERENCES Product(ProductID),
SupplierID INT NOT NULL,
FOREIGN KEY(SupplierID ) REFERENCES Supplier(ID),

);

ALTER TABLE Product
ADD Rating INT DEFAULT 0

ALTER TABLE Product
ADD CONSTRAINT new_default DEFAULT 'New' FOR Category ;

ALTER TABLE Product
DROP CONSTRAINT DF__Product__Rating__4BAC3F29;
ALTER TABLE Product 
DROP COLUMN Rating;


--DROP TABLE Customer;
--DROP DATABASE OnlineShoppingSystem;
--DML 
--Insert into Customer
INSERT INTO Customer (Email, Name, PhoneNumber, Address)
VALUES 
('tasneemgomaa@gmail com', 'tasneem', '01142522950 ','6th octuber'),
('ali@gmail com', 'ali', '01152522950 ','giza');

SELECT * FROM Customer
-- Insert into Product table
INSERT INTO Product (Category, Name, Price, Description)
VALUES 
('Electronics', 'Smartphone', 599.99, 'Latest model smartphone'),
('Clothing', 'T-Shirt', 19.99, 'Cotton T-Shirt');

SELECT * FROM Product

-- Insert into Supplier table
INSERT INTO Supplier (ContactInfo, Name)
VALUES 
('supplier1@example.com', 'Tech Supplies Inc.'),
('supplier2@example.com', 'Fashion World Ltd.');

SELECT * FROM Supplier

-- Insert into ShoppingOrder table
INSERT INTO ShoppingOrder (totalAmount, Status, CustomerID, OrderDetailsID, Quantity, Price)
VALUES 
(599.99, 'Pending', 1, 1, 1, 599.99),
(39.98, 'Shipping', 2, 2, 2, 19.99);
SELECT * FROM ShoppingOrder


-- Insert into Order_Product table
INSERT INTO Order_Product (ProductID, OrderID)
VALUES 
(1, 2), 
(2, 3); 
SELECT * FROM Order_Product

-- Insert into Product_OrderDetails table
INSERT INTO Product_OrderDetails (ProductID, OrderDetailsID)
VALUES 
(1, 1), 
(2, 2); 
SELECT * FROM Product_OrderDetails

-- Insert into Product_Supplier table
INSERT INTO Product_Supplier (ProductID, SupplierID)
VALUES 
(1, 1),
(2, 2);
SELECT * FROM Product_Supplier


UPDATE ShoppingOrder 
SET OderDate = GETDATE()
WHERE OrderID > 0

SELECT * FROM ShoppingOrder

DELETE Product 
WHERE Name != NULL
