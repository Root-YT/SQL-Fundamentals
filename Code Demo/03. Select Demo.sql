-- General format for referring to a Database Object

-- server.database.schema.object 

-- To refer to Employees Table in Northwind Database

Select * from Employees

-- Default schema is dbo

Select * from Northwind.dbo.Employees

-- Don't have to specify a server name for local system... Use it in a Network 

-- to change the scope or to use a database

Use Northwind;
GO

-- Difference between GO and ;

-- ; is used for Separating a SQL Statement
-- GO is used to Terminate or Close a SQL Batch 
-- Don't use ; after GO. That will raise an error.

-- Selecting Columns

SELECT FirstName, LastName FROM Employees;

SELECT * FROM Employees;

--Concatenating

SELECT LastName + ', ' + FirstName FROM Employees;

-- Aliasing column names

SELECT LastName + ', ' + FirstName AS [Full Name]
FROM Employees;

-- AS is optional

SELECT LastName + ', ' + FirstName FullName
FROM Employees;

-- Another aliasing option

   SELECT FullName = LastName + ', ' + FirstName 
   FROM Employees;

--SELECT and SELECT DISTINCT

SELECT Title FROM Employees;

SELECT DISTINCT Title FROM Employees;

-- Filtering Records

--WHERE Clause

SELECT CompanyName, City
FROM Customers
WHERE City = 'Paris';

--LIKE and Wildcard Characters - case insensitive

SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE 'S%';

SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%S';

SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%S%';

--Matching single characters using _

SELECT CustomerID
FROM Customers
WHERE CustomerID LIKE 'B___P';

--Matching from a list

SELECT CustomerID
FROM Customers
WHERE CustomerID LIKE 'FRAN[RK]';

--Specifying a range

SELECT CustomerID
FROM Customers
WHERE CustomerID LIKE 'FRAN[A-S]';

--Not containing

SELECT CustomerID
FROM Customers
WHERE CustomerID LIKE 'FRAN[^R]';

--BETWEEN

SELECT LastName, FirstName, PostalCode
FROM Employees
WHERE PostalCode BETWEEN '98103' AND '98999';

--Testing for Null

SELECT LastName, FirstName, Region
FROM Employees
WHERE Region = NULL;

--Three level logic ( True, False, NULL )

SELECT LastName, FirstName, Region
FROM Employees
WHERE Region IS NULL;

--AND requires both conditions to be true

SELECT LastName, City, PostalCode
FROM Employees
WHERE City = 'Seattle' AND PostalCode LIKE '9%';

--OR only requires one condition to be true

SELECT LastName, City, PostalCode
FROM Employees
WHERE City = 'Seattle' OR PostalCode LIKE '9%';

--NOT negates the expression

SELECT LastName, City, PostalCode
FROM Employees
WHERE City NOT LIKE 'Seattle';

--Operator Precedence: NOT, AND, OR

SELECT LastName, FirstName, City
FROM Employees
WHERE LastName LIKE '%S%'
	AND City NOT LIKE 'Seattle';

SELECT LastName, FirstName, City
FROM Employees
WHERE (LastName LIKE '%S%')
	AND (City NOT LIKE 'Seattle');

--IN Clause
-- One way to do it:

SELECT CustomerID, Country
FROM Customers
WHERE Country = 'France'
	OR Country = 'Spain'

-- Using IN -- to match in a list of elements

SELECT CustomerID, Country
FROM Customers
WHERE Country IN ('France', 'Spain');

--Sub Query
--IN with a subquery (that returns a list of elements)

SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN(SELECT CustomerID 
                        FROM Orders);
