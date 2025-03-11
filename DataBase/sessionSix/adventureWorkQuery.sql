--Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

SELECT S.SalesOrderID , S.ShipDate
FROM Sales.SalesOrderHeader S
WHERE S.ShipDate BETWEEN '7/28/2002' AND '7/29/2014'


--Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
SELECT P.ProductID , P.Name
FROM Production.Product p
WHERE P.StandardCost < 110

--Display ProductID, Name if its weight is unknown
SELECT P.ProductID , P.Name
FROM Production.Product P
WHERE P.Weight IS NULL

-- Display all Products with a Silver, Black, or Red Color
SELECT P.ProductID , P.Name , P.Color
FROM Production.Product P
WHERE P.Color IN ('Red','Black','Silver')


-- Display any Product with a Name starting with the letter B
SELECT P.ProductID , P.Name 
FROM Production.Product P
WHERE P.Name LIKE 'B%'


--Run the following Query
--Then write a query that displays any Product description with underscore value in its description.
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

SELECT P.Description
FROM Production.ProductDescription P
WHERE P.Description ='%\_%'  ;


-- Display the Employees HireDate (note no repeated values are allowed)
SELECT  DISTINCT *
FROM HumanResources.Employee 


--Display the Product Name and its ListPrice within the values of 100 and 120 the list should have the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)
SELECT ' The ' + p.Name +' is only! [' + CAST (P.ListPrice  AS VARCHAR(100))+']'
FROM Production.Product P
WHERE P.ListPrice BETWEEN 100 AND 120
ORDER BY P.ListPrice








