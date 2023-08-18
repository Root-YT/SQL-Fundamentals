-- Sorting Demo

Use Northwind;
Go

--ORDER BY

SELECT LastName, City
FROM Employees
ORDER BY City;

--Sorting in descending order

SELECT LastName, City
FROM Employees
ORDER BY City DESC;

--Sorting on multiple columns ( ASC optional)

SELECT LastName, City
FROM Employees
ORDER BY City DESC, LastName ASC;

--Sorting on an expression

SELECT LastName
FROM Employees
ORDER BY LEN(LastName);


------------------------

--Aggregate Functions
--COUNT - Counts the no of rows in an aggreate query
--COUNT_BIG - Same as count, but returns a bigint datatype (Huge databases)
--SUM -	Adds(sums) up the Column values
--AVG - Average of the Column values
--MIN - Returns the Lowest Column value in an aggreate query (can be applied to any datatype like string, datetime, int, etc)
--MAX - Returns the Largest Column value in an aggreate query

-----------------------

--Counting rows

SELECT COUNT(*)
FROM Employees;

SELECT COUNT(Region)
FROM Employees;

--Counting values in a Column vs. Row - remember NULL values

SELECT COUNT(*) AS NumEmployees, 
  COUNT(Region) AS NumRegion
FROM Employees;

--Counting with WHERE

SELECT COUNT(*) AS NumEmployeeSeattle
FROM Employees
WHERE City = 'Seattle';

--Grouping results
--Need number of employees from each city
--Gives an error

SELECT City, COUNT(*) AS NumEmployees
FROM Employees;

--Using Grouping
--Every field that you have in the select list, that is not part of the aggreate function 
--needs to be in the GROUP BY clause

SELECT City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City;

--ORDER BY with GROUP BY

SELECT City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
ORDER BY COUNT(*) DESC, City;

--Use alias in ORDER BY Clause

SELECT City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
ORDER BY NumEmployees DESC, City;

--HAVING

SELECT City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
HAVING COUNT(*) > 1
ORDER BY NumEmployees DESC, City;

-----------------------
--Difference between WHERE and HAVING Clause


--When you use a WHERE Clause in an aggreate group, the WHERE Clause is going to EXCLUDE ROWS before the Grouping Takes Place
--With the Having Clause, you can limit the Result Set after the aggreate value is calculated

--For Example-- The query we saw calculates the number of employees and displays them in DESC order

--The new query is going to do the same thing but is going to filter on cities that have only one employee 
--by applying the HAVING criteria after the aggreate is calculated

--Explanation: aggregate functions are applied on groups... 
--WHERE Clause filters the rows before aggreation could be applied
--HAVING Clause waits for aggreation to be completed before filtering the Result Set
----------------------


--Alias in HAVING Clause
--This causes an error, because you can't use an alias in the HAVING clause

SELECT City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
HAVING NumEmployees > 1
ORDER BY NumEmployees DESC, City;


--LIMITING THE RESULTS (Just the Output - after the entire processing is complete)

--TOP

SELECT TOP 3 
  City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
ORDER BY COUNT(*) DESC;

--TOP WITH TIES

SELECT TOP 3 WITH TIES
  City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
ORDER BY COUNT(*) DESC;

--TOP WITH PERCENT

SELECT TOP 41 PERCENT WITH TIES
  City, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY City
ORDER BY COUNT(*) DESC;


