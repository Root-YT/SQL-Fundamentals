--===============================
-- Controlling Flow of Execution
--===============================

-- General syntax
-- IF ThisStatementIsTrue 
--   ExecuteThisStatement
-- ELSE
--   ExecuteThisStatementInstead

------------------
-- Using IF...ELSE
------------------
IF (SELECT COUNT(*) FROM dbo.Products 
		WHERE UnitPrice > 100) > 0
	SELECT 'Found' AS HighPrice
ELSE
	SELECT 'Not Found' AS HighPrice

--------------------
-- Using BEGIN...END - for Multiple Statements
--------------------

IF EXISTS(SELECT * FROM dbo.Products 
	WHERE UnitPrice > 300)
	BEGIN
		SELECT 'Found' AS HighPrice;
		SELECT 'High Price Found' AS SampleOuput;
	END
ELSE
	BEGIN
		SELECT 'Not Found' AS HighPrice;
		SELECT 'High Price Not Found' AS SampleOuput;
	END


-------------
-- Using CASE
-------------
-- Syntax to compare one expression to other expressions
-- CASE input_expression
--   WHEN when_expression THEN result_expression
--     [...n]
--   [ELSE else_result_expression]
-- END

-- Using an input expression
--  and simple equality comparisons
SELECT CategoryName, Category =
	CASE CategoryName
		WHEN 'Meat/Poultry' THEN 'Protein'
		WHEN 'Seafood' THEN 'Protein'
		WHEN 'Grains/Cereals' THEN 'Carbs'
		WHEN 'Confections' THEN 'Carbs'
		WHEN 'Produce' THEN 'Carbs'
		WHEN 'Condiments' THEN 'Seasonings'
		ELSE 'Other'
	END,
	Description
FROM dbo.Categories ORDER BY Category;

-- Syntax for no input expression and
--  Boolean expressions for each WHEN
-- CASE
--      WHEN Boolean_expression THEN result_expression 
--     [ ...n ] 
--      [ 
--     ELSE else_result_expression 
--      ] 
-- END

SELECT CategoryName, Category =
	CASE 
		WHEN CategoryName IN('Meat/Poultry','Seafood') 
			THEN 'Protein'
		WHEN CategoryName IN('Grains/Cereals','Confections','Produce')
			THEN 'Carbs'
		WHEN CategoryName = 'Condiments'
			THEN 'Seasonings'
		ELSE 'Other'
	END,
	Description
FROM dbo.Categories
ORDER BY Category;

-----------------------------------------------------------
-- Using CASE to replace the C# conditional/ternary operator (?:)
-----------------------------------------------------------

-- C#:
-- Boolean_expression? result_if_true : result_if_false;

-- T-SQL:
-- CASE
--    WHEN Boolean_expression THEN result_if_true
--    ELSE result_if_false
-- END

DECLARE @Avg money
SELECT @Avg = AVG(UnitPrice) FROM dbo.Products
SELECT ProductName, UnitPrice, Ranking =
	CASE
		WHEN UnitPrice > @Avg THEN 'above average'
		ELSE 'below average'
	END
FROM dbo.Products;



SELECT Address = City +
	CASE 
		WHEN Region IS NULL THEN ' ' + PostalCode
		ELSE ', ' + Region +  ' ' + PostalCode
	END
FROM dbo.Customers;


----------------
-- Using WAITFOR
----------------
-- Syntax:
-- WAITFOR {DELAY 'time' | TIME 'time'}

--Pause for ten seconds
WAITFOR DELAY '000:00:10'
PRINT 'Done'
-- Watch the query duration counter in the lower right corner

--Pause until a certain time
WAITFOR TIME '11:41:30'
PRINT 'It is noon'


--------------
-- Using WHILE
--------------

USE master;
GO

-- create a new database and drop if it already exists and create a new one

if exists (select * from sysdatabases where name='SampleIterationV1')
		drop database SampleIterationV1;
go

create database SampleIterationV1;
go

--mount the database

use SampleIterationV1;
go

-- create a table
Create table Accounts(Tid int identity (1,1), Username varchar(50), Amount int);

insert into Accounts values('Anand', 10);
insert into Accounts values('Kumar', 100);
insert into Accounts values('Arun', 1000);
insert into Accounts values('Raja', 1);

select * from Accounts

select Avg(Amount) from Accounts

-- Loop through till the condition is satisfied

WHILE (SELECT AVG(Amount) FROM Accounts) <= 500
	BEGIN
		SELECT 'Updating Values' AS OutputValue;
		UPDATE Accounts SET Amount = Amount * 1.10;
	END


select Avg(Amount) from Accounts;

select * from Accounts;

Truncate table Accounts;
