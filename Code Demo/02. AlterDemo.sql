--create a table
create table emp(empid int, empname varchar(50))

--change empid type to varchar(50) from int
alter table emp alter column empid varchar(50)

--add a new column to the emp table empage of type int
alter table emp add empage int

--drop a column from the emp table empage
alter table emp drop column empage

--create a table with primary key (random name assigned)
create table stud(studid int primary key, studname varchar(50))

--drop a constriant by name
alter table stud drop constraint PK__stud__E270950B7C816B47

--create a constraint with name
create table cust(custid int constraint pk_cust primary key, custname varchar(50),
age int constraint age_check check(age>18))

--drop a constraint by name
alter table cust drop constraint age_check

--creating a table
create table customers(custid int primary key, cname varchar(50) not null, cphone varchar
(50))

--with foreign key
create table orders(orderid int primary key, cid int foreign key references customers
(custid), quantity int)

--pk with name
create table mycust(custid int, cname varchar(50), constraint pk_custid primary key(custid))

--PK and fk with name
create table myorders(orderid int constraint pk_orderid primary key, cid int constraint
fk_custid_myorders_customers foreign key references customers(custid), quantity int)

--dropping a table

drop table mycust

drop table myorders

--primary and foreign key with alter table commands

create table mycust(custid int not null, cname varchar(50))

alter table mycust add constraint pk_custid primary key(custid)

create table myorders(orderid int primary key, cid int, quantity int)

alter table myorders add constraint fk_custid_myorders_mycust foreign key(cid) references mycust(custid)