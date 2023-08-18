---------------------
-- Working with NULLs
---------------------

-- We often need to work with NULLs

-- Aggregate Functions ignore NULL values

-- Many default behaviors will change if NULL Values are involved

-- Equality with NULL (=) will give inconsistent results based on ANSI_NULLS property

-- When ANSI_NULLs is ON(Default), equality operator(=) doesn't give true or false but NULL as output

-- When ANSI_NULLs is OFF, equality operator(=) will give true or false as output

-- Lot of side effects for changing that setting :-}

-- This returns no rows unless you run: 
--  SET ANSI_NULLS OFF
-- (It is on by default)
--------------------------

SELECT CompanyName, City, Region 
FROM dbo.Suppliers
WHERE Region = NULL;

-- Change setting
SET ANSI_NULLS OFF;
-- Now run last query again

-- Restore ANSI_NULLS setting
SET ANSI_NULLS ON;

-- IS NULL Operator - It works reliably
--------------------------
SELECT CompanyName, City, Region
FROM dbo.Suppliers
WHERE Region IS NULL;

--------------------------------------
-- Using ISNULL Function to Replace Null Values with other string
--------------------------------------

-- Do not confuse with IS NULL Operator which is used to check NULL values

SELECT CompanyName, City, 
	ISNULL(Region, '???') AS Region 
FROM dbo.Suppliers;

----------------------------------
-- Using NULLIF to Convert Null Values
----------------------------------

-- The converse of ISNULL is NULLIF, IT replaces Actual Values with NULLS.

-- Useful to Eliminate values from Aggregation Functions to make it accurate


-- View the UnitsInStock Data
SELECT UnitsInStock FROM dbo.Products;

-- Several products are out of inventory

SELECT AVG(NULLIF(UnitsInStock, 0)) FROM dbo.Products;

-- this will produce different output than usual because NULLIF returns NULL when it encounters 0

-- instead of actual one which includes 0 in AVG function 

SELECT AVG(UnitsInStock) FROM dbo.Products;

----------------------------------
-- Using COALESCE to find 
--  the first non-NULL value 
--  in a series of expressions
----------------------------------

-- Syntax
-- COALESCE(expression1, expression2 [,...n])

SELECT COALESCE(3+NULL, 2*NULL, 5*2, 7);

SELECT CompanyName, Region, Country,
	City + ', ' + COALESCE(Region, Country) AS Location
FROM dbo.Suppliers;
