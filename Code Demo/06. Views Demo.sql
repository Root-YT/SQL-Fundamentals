-- SQL Views

--What is a View?

--A view is a virtual table whose contents are defined by a query. 
--Like a table, a view consists of a set of named columns and rows of data. 
--Unless indexed, a view does not exist as a stored set of data values in a database. 
--The rows and columns of data come from tables referenced in the query defining the view and are produced dynamically when the view is referenced.


--Why use a View?

--Views are generally used to focus, simplify, and customize the perception each user has of the database. 
--Views can be used as security mechanisms by letting users access data through the view, without granting the users permissions to directly access the underlying base tables of the view. 
--Views can be used to provide a backward compatible interface to emulate a table that used to exist but whose schema has changed.
--Views are used to improve performance by denormalizing and adding precomputed columns

--Creating a View

--This causes an error

USE tempdb;
CREATE TABLE dbo.Test 
(
	ID int NOT NULL, 
	TestName varchar(50) NOT NULL
);

insert into dbo.test values(1, 'test1');
insert into dbo.test values(2, 'test2');
insert into dbo.test values(3, 'test3');

CREATE VIEW dbo.ViewTest
AS 
	SELECT TestName FROM dbo.Test;


--Creating a View object requires a GO separator, as each of those statements must be executed as a transaction.

USE tempdb;
CREATE TABLE dbo.Test 
(
	ID int NOT NULL, 
	TestName varchar(50) NOT NULL
);

insert into dbo.test values(1, 'test1');
insert into dbo.test values(2, 'test2');
insert into dbo.test values(3, 'test3');

GO

CREATE VIEW dbo.ViewTest
AS 
	SELECT TestName FROM dbo.Test;
GO


Select * from dbo.ViewTest

---------------------------------------------------------------
--Creating a View from Multiple Tables using Joins

CREATE VIEW dbo.ProductsWithCategories
AS 
	SELECT p.ProductID, p.ProductName, p.UnitPrice, c.CategoryName FROM Northwind.dbo.Products as p join Northwind.dbo.Categories as c on p.CategoryID=c.CategoryID;
GO

-- Select Statement

Select * from dbo.ProductsWithCategories

-- Dropping a View

drop view dbo.ProductsWithCategories