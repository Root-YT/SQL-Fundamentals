USE Northwind;
GO

-- Inserting Data

-- Insert a single row 
-- Must provide the list of Columns or NULL values in the Values Clause

-- This causes an error

INSERT INTO dbo.Categories 
	VALUES('Vitamins');

INSERT INTO dbo.Categories (CategoryName)
  VALUES('Vitamins');

INSERT INTO dbo.Categories 
	VALUES('Vitamins1', NULL, NULL);



-- It is better to use a Column list everytime you insert data, even if it is not required
-- Protects you from changes made to table structure through alter statements

-- Inserting multiple values and dealing with delimiters

INSERT INTO dbo.Products
  (ProductName, CategoryID, UnitPrice, 
	QuantityPerUnit, Discontinued)
VALUES
  ('Pure ''Sunshine'' Orange Juice', 1, 9.99, 
	6, 0);

-- Notice use of two '' to insert a single ' into the table column

-- Insert multiple rows

-- First, create a table to insert into

CREATE TABLE dbo.Beverages(
	ProductID int NOT NULL,
	ProductName nvarchar(40),
	SupplierID int NULL,
	CategoryID int NULL,
	QuantityPerUnit nvarchar(20),
	UnitPrice money NULL,
	UnitsInStock smallint NULL,
	UnitsOnOrder smallint NULL,
	ReorderLevel smallint NULL,
	Discontinued bit NOT NULL
);

-- Now, insert using a SELECT clause

INSERT INTO dbo.Beverages
SELECT 
	ProductID, ProductName, SupplierID, 
	CategoryID, QuantityPerUnit, UnitPrice, 
	UnitsInStock, UnitsOnOrder, ReorderLevel,
	Discontinued
FROM dbo.Products
WHERE Products.CategoryID = 1;

-- Or you can include the field/column list

INSERT INTO dbo.Beverages(
	ProductID, ProductName, CategoryID, 
	UnitPrice, QuantityPerUnit, Discontinued)
SELECT 
	ProductID, ProductName, CategoryID, 
	UnitPrice, QuantityPerUnit, Discontinued
FROM dbo.Products
WHERE CategoryID = 1;

-- Inserting multiple rows with multiple INSERT statements

INSERT INTO dbo.Beverages
	([ProductID], ProductName, QuantityPerUnit, UnitPrice, 
		UnitsInStock, Discontinued)
	VALUES (25, 'Tea', 12, 56, 23, 0)
INSERT INTO dbo.Beverages
	([ProductID], ProductName, QuantityPerUnit, UnitPrice, 
		UnitsInStock, Discontinued)
	VALUES (26, 'Ginger Tea', 24, 8, 120, 0)
INSERT INTO dbo.Beverages
	([ProductID], ProductName, QuantityPerUnit, UnitPrice, 
		UnitsInStock, Discontinued)
	VALUES (27, 'Plain Milk', 12, 15, 46, 0)
GO

-- Using a row constructor in 2008

-- Limit for Row Constructor is 1000 rows at a time

INSERT INTO dbo.Beverages
	([ProductID], ProductName, QuantityPerUnit, UnitPrice, 
		UnitsInStock, Discontinued)
	VALUES 
		(28, 'Lemon Tea', 12, 56, 23, 0),
		(29, 'Black Coffee', 24, 8, 120, 0),
		(30, 'Badam Milk', 12, 15, 46, 0)
GO

-- Here you can't use different field list for different rows
-- It must match all the rows provided in the Values Clause
-- If required provide Full Field list and provide NULL values below

-- You can also create a new table using the SELECT INTO Statement

-- It creates the destination table(dbo.Produce) and inserts data into it




-- Using SELECT INTO

SELECT dbo.Products.* INTO dbo.Produce
FROM dbo.Products
WHERE CategoryID = 7;

-- You can only create a table once, so you cannot re-execute the above statement

-- Note:  

-- When you create a table using SELECT INTO the new table schema is going to match the original schema including IDENTITY Column
-- So the Produce table will have ProductID set to Identity
-- It also copies over Allow NULL Properties from source
-- It won't copy indexers, constraints and triggers from source

-- Disadvantages:

-- Allowing Users to create tables like this introduces problems with Backup and Restore
-- Also clutters the Database

-- Advantage:

-- Helpful for creating Temporary tables on the run for storing data before processing

-- TEMP Tables

-- A temp table is only accessible on the Current Connection where you created them
-- A temp table created using Management Studio is available only within that instance of management studio (invisible to other applications and other users even)
-- Each user can have his own temp table with the same name containing different data (Isolation)
-- Once the connection is terminated, SQL Server destroys the temp tables automatically
-- They are stored in a System Database called tempdb
-- It is similar to a normal table in all aspects as long as it is in same connection
-- Name must begin with #
-- You can use temp tables in Stored Procedures 
-- Those are destroyed when the Stored Procedure finishes(not connection termination)


-- Create a temp table

SELECT dbo.Products.* INTO #Produce
FROM dbo.Products
WHERE CategoryID = 7;

-- Check where it is created????

-- Select data from the temp table

SELECT * FROM #Produce;

-- Not always necessary to create temp tables using SELECT INTO Statement
-- You can use CREATE Statement

-- Create a temp table using CREATE TABLE

CREATE TABLE #Beverages(
	ProductID int NOT NULL,
	ProductName nvarchar(40),
	SupplierID int NULL,
	CategoryID int NULL,
	QuantityPerUnit nvarchar(20),
	UnitPrice money NULL,
	UnitsInStock smallint NULL,
	UnitsOnOrder smallint NULL,
	ReorderLevel smallint NULL,
	Discontinued bit NOT NULL
); 

-- Insert data into #Beverages

INSERT INTO #Beverages
SELECT 
	ProductID, ProductName, SupplierID, 
	CategoryID, QuantityPerUnit, UnitPrice, 
	UnitsInStock, UnitsOnOrder, ReorderLevel,
	Discontinued
FROM dbo.Products
WHERE Products.CategoryID = 1;

-- Can create GLOBAL TEMP TABLES
-- These are temp tables that are shared across connections
-- Name must begin with ##
-- Global temp tables remains active until the connection that created it closes AND no other connection actively uses it


-- Creating a global temp table

CREATE TABLE ##Categories
(
	CategoryID int NOT NULL PRIMARY KEY CLUSTERED,
	CategoryName varchar(255)
);


-- Using BULK INSERT

-- Create a table to bulk insert into

CREATE TABLE dbo.NewProducts (
	ProductID int NOT NULL,
	ProductName nvarchar (50) NOT NULL ,
	UnitPrice money NULL
);


BULK INSERT Northwind.dbo.NewProducts
	FROM 'C:\Data\Products.txt'	-- Change path accordingly
	WITH 
	(
		FIELDTERMINATOR = '\t',
		ROWTERMINATOR = '\n'
);