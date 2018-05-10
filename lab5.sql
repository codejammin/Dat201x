USE AdventureWorksLT2012;

--Challenge 1: Retrieve Product Information
--1. Retrieve the name and approximate weight of each product
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight
FROM SalesLt.Product;

--2. Retrieve the year and month in which products were first sold
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, DATENAME(month, SellStartDate) AS SellStartMonth
FROM SalesLt.Product;

--3. Extract product types from product numbers
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight, 
YEAR(SellStartDate) AS SellStartYear, DATENAME(month, SellStartDate) AS SellStartMonth,
SUBSTRING(ProductNumber,1 , 2)AS ProductType
FROM SalesLt.Product;

--4. Retrieve only products with a numeric size
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight, 
YEAR(SellStartDate) AS SellStartYear, DATENAME(month, SellStartDate) AS SellStartMonth,
SUBSTRING(ProductNumber,1 , 2)AS ProductType
FROM SalesLt.Product
WHERE ISNUMERIC(Size) = 1;

--Challenge 2: Rank Customers by Revenue
--1. Retrieve companies ranked by sales totals
SELECT CompanyName, TotalDue AS Revenue,
RANK() OVER (ORDER BY TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS soh
JOIN SalesLT.Customer AS c
ON c.CustomerID = soh.CustomerID;

--Challenge 3: Aggregate Product Sales
--1. Retrieve total sales by product
SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.Product as p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
Group By p.Name
ORDER BY TotalRevenue DESC;

--2. Filter the product sales list to include only products that cost over $1,000
SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.Product as p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000
Group By p.Name
ORDER BY TotalRevenue DESC;

--3. Extract product types from product numb
SELECT Name, SUM(LineTotal) AS TotalRevenue, SUBSTRING(ProductNumber,1,2) AS ProductType
FROM SalesLT.Product as p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000 AND ISNUMERIC(Size) = 1
Group By p.Name, ProductNumber
ORDER BY TotalRevenue DESC;

--3. Filter the product sales groups to include only total sales over $20,000
SELECT Name, SUM(LineTotal) AS TotalRevenue, SUBSTRING(ProductNumber,1,2) AS ProductType
FROM SalesLT.Product as p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000 AND ISNUMERIC(Size) = 1
Group By p.Name, ProductNumber
ORDER BY TotalRevenue DESC;

--3. Filter the product sales groups to include only total sales over $20,000
SELECT Name, SUM(LineTotal) AS TotalRevenue, SUBSTRING(ProductNumber,1,2) AS ProductType
FROM SalesLT.Product as p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000 AND ISNUMERIC(Size) = 1
Group By p.Name, ProductNumber
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;