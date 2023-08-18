-- Using Variables

Use Northwind;

DECLARE @local char(13); -- declaration
SET @local = 'Local Phone: '; -- initialize/define
-- Or --
SELECT @local = 'Local Phone: ';

SELECT @local AS Value;

SELECT LastName, FirstName, @local + HomePhone AS Phone
	FROM dbo.Employees
	ORDER BY LastName, FirstName;
GO

-- Single statement declaration and initialization in SQL Server 2008

DECLARE @local char(13) = 'Local Phone: ';
SELECT @local AS Value;
SELECT LastName, FirstName, @local + HomePhone AS Phone
	FROM dbo.Employees
	ORDER BY LastName, FirstName;
GO
--------------------------------------------------------------

--  Compound Operators - can be used after SQL Server 2008

DECLARE @i int = 5
SET @i += 1					-- Increment @i = @i + 1
SELECT @i AS AddEquals
SET @i -= 3					-- Decrement
SELECT @i AS SubtractEquals
SET @i *= 10				-- Multiplication
SELECT @i AS MultEquals
SET @i /= 2					-- Division
SELECT @i AS DivEquals
SET @i %= 4					-- Modulus
SELECT @i AS ModEquals
SET @i &= 15				-- Bitwise And
SELECT @i AS BitAndEquals
SET @i ^= 13				-- Bitwise Exclusive Or
SELECT @i AS BitXorEquals
SET @i |= 5					-- Bitwise Or
SELECT @i AS BitOrEquals

--------------------------------------------------------------

-- Using CAST and CONVERT

--Transact SQL or T-SQL is strictly (strongly) typed. So it requires explicit Casting or Conversion when incompatible types are used

-- Syntax
-- CAST (expression AS data_type [(length)]) 
-- CONVERT (data_type [(length)], expression [, style])

--This will give you an error

DECLARE @msg varchar(20);
SELECT @msg = 'The result is: ' + (2+2);
PRINT @msg;

--Fix the problem using Cast or Convert
DECLARE @msg varchar(20);
SELECT @msg = 'The result is: ' +
	CAST((2+2) AS varchar(1));
PRINT @msg;

DECLARE @msg varchar(20);
SELECT @msg = 'The result is: ' +
	CONVERT(varchar(1), (2+2));
PRINT @msg;
----------------------------------------------------------

--When SQL Server evaluates an expression that includes multiple data types, it picks one data type for the result and attempts to convert each part of the expression to that one resulting type. The type that SQL Server picks is the one with the highest type precedence

--  Data Type precedence

--user-defined data types (highest)
--sql_variant
--xml
--datetimeoffset 
--datetime2
--datetime
--smalldatetime
--date
--time
--float
--real
--decimal
--money
--smallmoney
--bigint
--int
--smallint
--tinyint
--bit
--ntext
--text
--image
--timestamp
--uniqueidentifier
--nvarchar
--nchar
--varchar
--char
--varbinary
--binary (lowest)


-- See what happens

DECLARE @msg varchar(20);
SELECT @msg = '1' + (2+2);
PRINT @msg;

--SQL Server does have some limited support for converting data types (implicit conversions).

---------------------------------------------------------

-- Using CONVERT with style

-- MSSQL GETDATE() returns current system date and time in standard internal format

SELECT GETDATE();

-- style 1 formats date in short date format yy

-- add 100 to style to get yyyy format... Can add 100 to any style to get yyyy instead of yy...

-- try subtracting 100 to get yy instead of yyyy....


SELECT CONVERT(varchar(20), GETDATE(), 1) AS '1 - mm/dd/yy  US with yy'

SELECT CONVERT(varchar, GETDATE(), 100) AS '100 - may dd yyyy hh:mmAM (or PM) Default'

SELECT CONVERT(varchar, GETDATE(), 101) AS '101 - mm/dd/yyyy  US'            

SELECT CONVERT(varchar, GETDATE(), 102) AS '102 - yyyy.mm.dd  ANSI'    

SELECT CONVERT(varchar, GETDATE(), 103) AS '103 - dd/mm/yyyy  British/French'

SELECT CONVERT(varchar, GETDATE(), 104) AS '104 - dd.mm.yyyy  German'

SELECT CONVERT(varchar, GETDATE(), 105) AS '105 - dd-mm-yyyy  Italian'

SELECT CONVERT(varchar, GETDATE(), 106) AS '106 - dd mon yyyy'

SELECT CONVERT(varchar, GETDATE(), 107) AS '107 - mon dd, yyyy'

SELECT CONVERT(varchar, GETDATE(), 108) AS '108 - hh:mm:ss'

SELECT CONVERT(varchar, GETDATE(), 109) AS '109 - mon dd yyyy hh:mm:ss:mmm AM (or PM) Default + Milliseconds'

SELECT CONVERT(varchar, GETDATE(), 110) AS '110 - mm-dd-yyyy  US'

SELECT CONVERT(varchar, GETDATE(), 111) AS '111 - yyyy/mm/dd  Japan'

SELECT CONVERT(varchar, GETDATE(), 112) AS '112 - yyyymmdd  ISO'

SELECT CONVERT(varchar, GETDATE(), 113) AS '113 - dd mon yyyy hh:mm:ss:mmm'

SELECT CONVERT(varchar, GETDATE(), 114) AS '114 - hh:mm:ss:mmm(24h)'

SELECT CONVERT(varchar, GETDATE(), 120) AS '120 - yyyy-mm-dd hh:mm:ss(24h)'

SELECT CONVERT(varchar, GETDATE(), 121) AS '121 - yyyy-mm-dd hh:mm:ss.mmm'

SELECT CONVERT(varchar, GETDATE(), 126) AS '126 - yyyy-mm-ddThh:mm:ss.mmm'

 -- Using STR to convert and format

-- Syntax
-- STR(float_expression[, length[, decimal]])

use Northwind;

SELECT UnitPrice, STR(UnitPrice, 6, 1) AS Formatted
FROM dbo.Products
ORDER BY UnitPrice DESC;
