--Advanced SQL Query - Set Operations

--SQL Union, Union All, Intersect, Except

-- SQL Union

--The UNION operator is used to combine the result-set of two or more SELECT statements.

--Every SELECT statement within UNION must have the same number of columns
--The columns must also have similar data types
--The columns in every SELECT statement must also be in the same order
--The UNION operator selects only distinct values by default. 
--The column names in the result-set are usually equal to the column names in the first SELECT statement.

--To allow duplicate values, use UNION ALL

select Companyname, contactname, city from Customers
union
select Companyname, contactname, city from Suppliers


select city from Customers where country='France'
union
select city from Suppliers where country='France'


select city from Customers where country='France'
union all
select city from Suppliers where country='France'


select city from Customers where country='France'
union all
select city from Suppliers where country='France' order by city


select city from Customers where country='France'
union
select city from Suppliers where country='France'
union 
select city from Employees

-- SQL Intersect - The INTERSECT operator keeps the rows that are common to all the queries

select city from Customers where country='France'
intersect
select city from Suppliers where country='France'

-- SQL Except - The EXCEPT operator lists the rows in the first that are not in the second with no duplicates.

select city from Customers where country='France'
except
select city from Suppliers where country='France'
