--Challenge 1: Retrieve Customer Addresses
--Retrieve billing addresses
SELECT CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
--Join on CustomerID
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a
--Join on AddressID
ON ca.AddressID = a.AddressID
WHERE AddressType = 'Main Office';

--2. Retrieve shipping addresses
SELECT CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
--Join on CustomerID
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a
--Join on AddressID
ON ca.AddressID = a.AddressID
WHERE AddressType = 'Shipping';

--Combine billing and shipping addresses

SELECT CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
--Join on CustomerID
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a
--Join on AddressID
ON ca.AddressID = a.AddressID
WHERE AddressType = 'Main Office'
UNION ALL
SELECT CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer as c
JOIN SalesLT.CustomerAddress as ca
--Join on CustomerID
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as a
--Join on AddressID
ON ca.AddressID = a.AddressID
WHERE AddressType = 'Shipping'
ORDER BY CompanyName, AddressType;

--Challenge 2: Filter Customer Addresses
--1. Retrieve customers with only a main office address
SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- join the CustomerAddress table
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- use the appropriate join to join the CustomerAddress table
JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON ca.CustomerID = c.CustomerID
-- use the appropriate join to join the Address table
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
-- filter for the appropriate AddressType
WHERE AddressType = 'Shipping'
ORDER BY c.CompanyName;

--2. Retrieve only customers with both a main office address and a shipping address
-- select the CompanyName column
SELECT c.CompanyName
-- from the appropriate table
FROM SalesLT.Customer AS c
-- use the appropriate join with the appropriate table
JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON c.CustomerID = ca.CustomerID
-- use the appropriate join with the appropriate table
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
-- filter based on AddressType
WHERE ca.AddressType = 'Main Office'
INTERSECT
-- select the CompanyName column
SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- use the appropriate join with the appropriate table
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
-- filter based on AddressType
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;