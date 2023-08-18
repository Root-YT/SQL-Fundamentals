--creating a table

--General syntax
-- create table tablename(columnname type constraints, columnname type constraints...)

create table employees(empid int primary key not null, empname varchar(50) not null, empage int)

--inserting records
--General syntax
-- insert into tablename values(columnvalues in the same order as in table definition separated by ,)


insert into employees values(1,'anand',36)
insert into employees values(2,'kumar',27)
insert into employees values(3,'arun',28)
insert into employees values(4,'raja',29)

--select all records
select * from employees

--select with filter
select * from employees where empid=1

--create with autoincrement or identity

create table students(studid int identity(1,1) not null primary key, studname varchar(50), studage int)

insert into students values(1, 'arun', 25) --error 

insert into students values('anand',25)
insert into students values('arun', 25)

select * from students

--allowing null
create table customers(cid int primary key not null, custname varchar(50) not null, custphone varchar(50), custdob datetime)

--date is entered as a string enclosed in ' ', in the following format YYYYMMDD with no separators

insert into customers values(1,'anand','12345','20230805')

insert into customers values(2,'kumar',Null,'20230805')

select * from Customers

--selective insert to leave null enabled columns and column with defaults

--General syntax

-- insert into tablename(column names to be inserted) values(actual values in same order as given in columnnames section before)

insert into customers(cid, custname, custdob) values(3,'raja','20230805')

select * from customers

--setting multiple columns as primmary key

create table studmarks(studid int not null, examtype varchar(50) not null, examyear int not null, subject varchar(50) not null, mark int, primary key(studid, examtype, examyear, subject))

select * from studmarks

insert into studmarks values(101, 'QTY', 2023, 'English', 78)
insert into studmarks values(101, 'QTY', 2023, 'Science', 68)
insert into studmarks values(101, 'QTY', 2023, 'Maths', 85)
insert into studmarks values(101, 'QTY', 2023, 'Social', 90)
insert into studmarks values(101, 'QTY', 2023, 'Tamil', 88)

insert into studmarks values(101, 'HY', 2023, 'English', 70)
insert into studmarks values(101, 'HY', 2023, 'Science', 98)
insert into studmarks values(101, 'HY', 2023, 'Maths', 84)
insert into studmarks values(101, 'HY', 2023, 'Social', 94)
insert into studmarks values(101, 'HY', 2023, 'Tamil', 76)

select * from studmarks


-- Foreign Key

Create table Bills(BillNo int primary key, customer int foreign key references customers(cid), BillAmount int not null) 
 

--Column Level Constraints

create table cars(carid varchar(50) not null primary key, carcolor varchar(50) not null default 'White', carprice int not null check(carprice>10000), regno varchar(50) not null unique)

--constraints demo

insert into cars values(1, 'red', 100000, '123')

insert into cars(carid, carprice, regno) values(2, 100000, '124')
insert into cars values(3, 'red', 100000, '125')
insert into cars values(4, 'red', 10001, '126')

select * from cars

--update statement
-- General syntax

-- update tablename set columnname=newvalue where columnname=value and columnname=value...

-- here make sure that you identify/select the right set of record or records before making the update otherwise all records will be accidentally updated.

select * from cars where carid=4

update cars set carprice=20000 where carid=4

select * from cars

--updating multiple columns

update cars set carprice=25000, carcolor='Green' where carid=4

-- delete statement
-- General syntax

-- Delete from tablename where columnname=value and columnname=value...

-- here make sure that you identify/select the right set of record or records before deleting otherwise all records will be accidentally deleted.

delete from cars where carid=1

delete from cars where carid=2

select * from cars






