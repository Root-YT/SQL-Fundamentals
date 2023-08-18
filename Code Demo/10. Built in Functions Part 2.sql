----------------------------
-- Using SPACE
-- (display results as text)
----------------------------
-- Syntax
-- SPACE ( integer_expression )

select firstname + ' '+ lastname from employees

SELECT FirstName + SPACE(15-LEN(FirstName)) 
	+ LastName AS NameInColumns
FROM dbo.Employees;

--------------
-- Using CHAR
--------------
-- Syntax
-- CHAR ( integer_expression )

SELECT CHAR(71)+CHAR(13)+CHAR(72) 
	AS CharactersWithCarriageReturn;

--------------
-- Using ASCII
--------------
-- Syntax
-- ASCII ( character_expression )

SELECT ASCII('G') as AsciiG;

------------------------
-- Using LOWER and UPPER
------------------------
-- Syntax
-- LOWER ( character_expression )
-- UPPER ( character_expression )

SELECT UPPER(FirstName) AS FIRSTNAME, 
  LOWER(LastName) AS lastname
FROM dbo.Employees

-- Use for case-insensitive filtering
-- of case-sensitive data.
SELECT CompanyName
FROM dbo.Customers
WHERE CHARINDEX(UPPER('the '),UPPER(CompanyName))>0;

-- (The most efficient way to perform
--   case-sensitive or case-insensitive
--   searches is to specify a collation for the query.)

-- Case-sensitive: --case sensitive accent sensitive 
SELECT CompanyName
FROM dbo.Customers
WHERE CompanyName LIKE '%the %' 
COLLATE SQL_Latin1_General_CP1_CS_AS;

-- Case-insensitive:
SELECT CompanyName
FROM dbo.Customers
WHERE CompanyName LIKE '%the %' 
COLLATE SQL_Latin1_General_CP1_CI_AI;

------------------------
-- Using LTRIM and RTRIM
------------------------
-- Syntax
-- LTRIM ( character_expression )
-- RTRIM ( character_expression )

SELECT LTRIM(RTRIM('  Hello  ')) + 'There' AS Trimmed;

----------------
-- Using GETDATE
----------------
SELECT GETDATE() AS RightNow;

----------------------------
-- Using MONTH, DAY and YEAR
----------------------------
SELECT MONTH(GETDATE()) AS ThisMonth,
	DAY(GETDATE()) AS ThisDay,
	YEAR(GETDATE()) AS ThisYear;

-----------------
-- Using DATEPART
-----------------
SELECT 
	DATEPART(dy, GETDATE()) AS DayOfYear,
	DATEPART(dd, GETDATE()) AS DayNum,
	DATEPART(ww, GETDATE()) AS WeekNum,
	DATEPART(dw, GETDATE()) AS Weekday,
	DATEPART(hh, GETDATE()) AS Hour,
	DATEPART(mi, GETDATE()) AS Minute,
	DATEPART(ss, GETDATE()) AS Seconds;

------------------------------
-- Using DATENAME
------------------------------
SELECT 
	DATENAME(qq, GETDATE()) AS Quarter,
	DATENAME(mm, GETDATE()) AS Month,
	DATENAME(dw, GETDATE()) AS Weekday,
	DATENAME(hh, GETDATE()) AS Hour,
	DATENAME(mi, GETDATE()) AS Minute,
	DATENAME(ss, GETDATE()) AS Seconds;

-----------------
-- Using DATEADD
-----------------
SELECT
	DATEADD(yy, -2, GETDATE()) AS AddYear, -- use negatvie values to subtract
	DATEADD(mm, 2, GETDATE()) AS AddMonth,
	DATEADD(dd, 2, GETDATE()) AS AddDay;

-----------------
-- Using DATEDIFF
-----------------
SELECT 
	OrderDate, RequiredDate, ShippedDate, 
	DATEDIFF(dd, OrderDate, RequiredDate) AS LeadTime,
	DATEDIFF(dd, OrderDate, ShippedDate) AS DaysToShip,
	DATEDIFF(dd, ShippedDate, RequiredDate) AS DaysEarly
FROM dbo.Orders;

-------------------------
-- Last day of the month
-------------------------
DECLARE @date datetime
SET @date='2023-02-05'
SELECT DATEADD(dd, -DAY(DATEADD(m,1,@date)),  
	DATEADD(m,1,@date)) AS LastDayOfMonth
