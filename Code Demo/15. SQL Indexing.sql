-- SQL Indexing

Select * from Products

exec sp_helpindex Products

--create an index

CREATE INDEX [IDX_UnitPrice] ON NewProducts (UnitPrice)

drop index IDX_UnitPrice on NewProducts

--index on multiple columns
CREATE INDEX [IDX_ProductName_UnitPrice] ON NewProducts (ProductName, UnitPrice)

drop index IDX_ProductName_UnitPrice on NewProducts

exec sp_helpindex NewProducts

--Unique Index - column must contain unique values

CREATE UNIQUE INDEX [IDX_ProductName] ON NewProducts (ProductName)

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE (UnitPrice > 12.5) AND (UnitPrice < 14)

DELETE FROM Products WHERE UnitPrice <= 1 

UPDATE Products SET Discontinued = 1 WHERE UnitPrice > 15 

SELECT * FROM PRODUCTS WHERE UnitPrice BETWEEN 12 AND 16 

SELECT * FROM Products ORDER BY UnitPrice ASC 





