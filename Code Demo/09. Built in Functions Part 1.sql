------------------
-- Using IsNumeric
------------------
SELECT PostalCode, ISNUMERIC(PostalCode)
FROM dbo.Customers;

-- Some non-numeric characters will pass
SELECT ISNUMERIC('123e4'), ISNUMERIC('123d4'),
	CAST ('123e4' AS float), CAST ('123d4' AS float)

-------------------------
-- Using RAND
-------------------------

-- With an automatic random seed,
--  different numbers every time.
-- Execute multiple times:
SELECT RAND(), RAND(), RAND();

-- With a fixed seed,
--  the same series every time.
-- Execute multiple times:
SELECT RAND(45), RAND(), RAND();

------------------
-- Using ROUND
------------------
-- Syntax
-- ROUND(expression, length[, function]) 15.05

SELECT UnitPrice, 
	ROUND(UnitPrice, 0) AS RoundedDollars, 
	ROUND(UnitPrice, 0, 1) AS TruncatedDollars, 
	ROUND(UnitPrice, 1) AS ToTensOfCents,
	ROUND(UnitPrice, -1) AS ToTensOfDollars
FROM dbo.Products;

-- Combining RAND and ROUND
DECLARE @minID int, @maxID int
SET @minID=(SELECT MIN(EmployeeID) FROM dbo.Employees)
SET @maxID=(SELECT MAX(EmployeeID) FROM dbo.Employees)

SELECT EmployeeID AS LuckyID, LastName AS LuckyName 
FROM dbo.Employees 
WHERE EmployeeID = 
	ROUND(@minID + (RAND()*(@maxID-@minID)),0);

----------------
-- Using REPLACE - Replaces all occurances - case insensitive
----------------
-- Syntax
-- REPLACE ( string_expression , string_pattern , string_replacement )

SELECT REPLACE('ABC ABC ABC', 'a', 'c');

SELECT QuantityPerUnit, 
	REPLACE(QuantityPerUnit, '12 ', 'twelve ') AS Twelve
FROM dbo.Products;

--------------
-- Using STUFF - deletes a part of a string and then inserts another part into the string, starting at a specified position 
--------------
-- Syntax
-- STUFF (expr1, start, length, expr2)

SELECT STUFF('123456', 3, 2, 'xxxx');

----------------------------
-- Using LEN, LEFT and RIGHT
----------------------------
-- Syntax
-- LEN (string_expression) 
-- LEFT (string_expression, integer_numchars)
-- RIGHT (string_expression, integer_numchars)

SELECT ProductName, 
	LEFT(ProductName, LEN(ProductName) -3) AS Lefty, 
	RIGHT(ProductName, LEN(ProductName) -3) AS Righty
FROM dbo.Products;

------------------
-- Using SUBSTRING
------------------
-- Syntax
-- SUBSTRING (value_expression ,start_expression , length_expression )

SELECT SUBSTRING(FirstName, 1, 1) + '. ' + LastName
FROM dbo.Employees;

------------------
-- Using CHARINDEX
------------------
-- Syntax
-- CHARINDEX ( expression1 ,expression2 [ , start_location ] ) 

SELECT HomePhone, CHARINDEX(')', HomePhone) AS StartPos
FROM dbo.Employees;

SELECT HomePhone, 
	LEFT(HomePhone, CHARINDEX(')', HomePhone)) AS AreaCode,
	SUBSTRING(HomePhone, CHARINDEX(')', HomePhone)+2, 
		LEN(HomePhone)-CHARINDEX(')', HomePhone)+1) AS Number
FROM dbo.Employees;

SELECT ProductName AS TofuProducts
FROM dbo.Products
WHERE CHARINDEX('tofu', ProductName) > 0;

------------------
-- Using PATINDEX
------------------
-- Syntax
-- PATINDEX ( '%pattern%' , expression )

-- PATINDEX supports wildcards.
SELECT ProductName, QuantityPerUnit 
FROM dbo.Products
WHERE PATINDEX('24 - % g pkgs.', QuantityPerUnit) > 0;

SELECT ProductName, QuantityPerUnit 
FROM dbo.Products
WHERE PATINDEX('24 - __ g pkgs.', QuantityPerUnit) > 0;

-- Using bracketed values
SELECT PostalCode
FROM dbo.Customers
WHERE PATINDEX('%[^0-9]%',PostalCode)=0;

-- PATINDEX can be used with text, ntext and image columns
SELECT CategoryName, Description, 
	PATINDEX('%sweet%', Description) AS SweetFoundAt
FROM dbo.Categories
WHERE PATINDEX('%sweet%', Description) > 0;

