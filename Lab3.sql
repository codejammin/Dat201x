--Challenge 1: Generate Invoice Reports
--1. Retrieve customer orders
SELECT c.CompanyName, SalesOrderID, TotalDue
FROM SalesLT.Customer as c
JOIN Saleslt.SalesOrderHeader as s
ON c.CustomerID = s.CustomerID;

--2. Retrieve customer orders with addresses
SELECT c.CompanyName, SalesOrderID, TotalDue, ca.AddressType, a.AddressLine1, ISNULL(a.AddressLine2, '') AS AddressLine2,
a.City, a.StateProvince, a.PostalCode, a.CountryRegion 
FROM SalesLT.Customer AS c
-- Join SalesOrder Table
JOIN Saleslt.SalesOrderHeader AS s
ON c.CustomerID = s.CustomerID
--Join CustomerAddress Table
LEFT JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID AND AddressType = 'Main Office'
--Join Address Table
LEFT JOIN SalesLT.Address AS a
on ca.AddressID = a.AddressID;


--Challenge 2: Retrieve Sales Data
--1. Retrieve a list of all customers and their orders
SELECT SalesOrderID, CompanyName, FirstName, LastName, TotalDue
FROM SalesLT.Customer as c
-- join based on CustomerID
LEFT JOIN SalesLT.SalesOrderHeader as sh
ON c.CustomerID = sh.CustomerID
-- order the SalesOrderIDs from highest to lowest
ORDER BY SalesOrderID DESC;

--2. Retrieve a list of customers with no address
SELECT c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON c.CustomerID = ca.CustomerID
-- filter for when the AddressID doesn't exist
WHERE ca.AddressID IS NULL;

--3. Retrieve a list of customers and products without orders
SELECT c.CustomerID, p.ProductID
FROM SalesLT.Customer AS c
FULL JOIN SalesLT.SalesOrderHeader AS so
ON c.CustomerID = so.CustomerID
-- join based on the SalesOrderID
FULL JOIN SalesLT.SalesOrderDetail AS sd
ON so.SalesOrderID = sd.SalesOrderID
-- join based on the ProductID
FULL JOIN SalesLT.Product as p
ON sd.ProductID = p.ProductID
-- filter for nonexistent SalesOrderIDs
WHERE so.SalesOrderID IS NULL
ORDER BY so.SalesOrderID, p.ProductID
;



