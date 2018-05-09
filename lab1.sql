USE AdventureWorksLT2012;

--Challenge 1: Retrieve Customer Data
	--1. Retrieve customer details
SELECT * FROM SalesLT.Customer;

	--2. Retrieve customer name data
SELECT Title, FirstName, MiddleName, LastName, Suffix 
FROM SalesLT.Customer;

	--3. Retrieve customer names and phone numbers
SELECT SalesPerson, isnull(Title, FirstName) + ' ' + LastName AS FullName , Phone 
FROM SalesLT.Customer;

--Challenge 2: Retrieve Customer and Sales Data
	--1. Retrieve a list of customer companies
SELECT STR(CustomerID) + ': ' + CompanyName
FROM SalesLT.Customer;

	--2. Retrieve a list of sales order revisions
SELECT SalesOrderNumber + ' (' + CAST(RevisionNumber AS VARCHAR(5)) + ')' AS SalesDetail, CONVERT(NVARCHAR(50), OrderDate, 126) AS OrderDate_ANSI
FROM SalesLT.SalesOrderHeader;

--Challenge 3: Retrieve Customer Contact Details
	--1. Retrieve customer contact names with middle names if known
SELECT
	CASE
		WHEN MiddleName IS NULL THEN FirstName + ' ' + LastName
		ELSE FirstName + ' ' + MiddleName + ' ' + LastName
	END AS FullName
FROM SalesLT.Customer;

	--2. Retrieve primary contact details
SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

		--Run this to remove email addresses and verify query
		UPDATE SalesLT.Customer
		SET EmailAddress = NULL
		WHERE CustomerID % 7 = 1;

	--3. Retrieve shipping status
SELECT SalesOrderID, OrderDate, 
	CASE
		WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;

		--Run this to remove data and verify query
		UPDATE SalesLT.SalesOrderHeader
		SET ShipDate = NULL
		WHERE SalesOrderID > 71899;