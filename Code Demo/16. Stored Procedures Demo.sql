-- General Syntax
-- stp_action_object
--create/alter procedure proc_name(@param1 type, @param2 type)
--as
--begin
	--code
--end

-- Create sample tables

create table employee(empid int not null, empname varchar(50), adid int)

create table address(adid int primary key, city varchar(50))


--create a stored procedure for inserting data into employee 

create procedure stp_employee_insert(@id int, 
@name varchar(50), @adid int)
as
begin
	insert into employee values(@id,@name,@adid)
end

--executing a stored procedure

exec stp_employee_insert 1,'anand',101

select * from employee

-- execute using key value pairs

exec stp_employee_insert @name='kumar',
@adid=102,
@id=2 

select * from employee

exec stp_employee_insert 1,'anand',101

delete from employee where empid=1

--create a stored procedure for inserting data into employee and to check primary key constraint to provide custom error messages

alter procedure stp_employee_insert(@id int, @name varchar(50), @adid int)
as
begin

	if exists(select empid from employee where empid=@id)
		begin
			raiserror('employee id already exists...',17,1)
		end
	else
		begin
			insert into employee values(@id,@name,@adid)
		end
	
end

--executing stp

select * from employee

exec stp_employee_insert 3,'anand3',101

--checking foreign key constraints in stp

alter procedure stp_employee_insert(@id int, 
@name varchar(50), @adid int)
as
begin

	if exists(select empid from employee where empid=@id)
		begin
			raiserror('employee id already exists...',1,1)
		end
	else
		begin

			if exists(select adid from address where adid=@adid)
				begin
					insert into employee values(@id,@name,@adid)
				end
			else
				begin
					raiserror('Invalid address id... Check address table',16,1)
				end
			
		end
	
end

--exec using invalid foreign keys

select * from employee

select * from address

exec stp_employee_insert 4,'raja',103

insert into address values(101,'trichy')
insert into address values(102,'trichy1')
insert into address values(103,'trichy2')


--create stp insert with auto increment support and dependent tables
--Cascading operations

drop table employee

drop table address

--create the tables as follows

create table employee(empid int not null, empname varchar(50), adid int)

create table address(adid int identity(1,1) primary key, city varchar(50))

--create stp to insert employee details

create procedure stp_employeedetails(@id int, @name varchar(50),@city varchar(50))
as
begin

	declare @addressid int
	insert into address values(@city)
	set @addressid=(select max(adid) from address)

	if exists(select empid from employee where empid=@id)
		begin
			raiserror('Employee id already exists',16,1)
		end

	else
		begin
			insert into employee values(@id, @name,@addressid)
		end

end


-- executing the stp

select * from employee

select * from address

exec stp_employeedetails 1, 'anand','trichy'

-- validations using stp
-- some text conversions are also possible


create table customers(custname varchar(50),email varchar(50), country varchar(50), city varchar(50))

create procedure stp_customers_insert(@name varchar(50), @mail varchar(50), @country varchar(50), @city varchar(50))
as
begin
--validate primary key

	if exists(select custname from customers where custname=@name)
		begin
			--if customer name already exists
			raiserror('Customer name already exists...',16,1)
		end
	else
--if customer name is not already there
		begin
--to change to upper case

			set @name=upper(@name)
			set @country=upper(@country)
			set @city= upper(@city)

--validate email

			declare @validemail tinyint
			set @validemail=charindex('@',@mail)
			if @validemail<2
				begin
					raiserror('invalid email id.....',16,1)
				end

			else
				begin
					insert into customers values(@name, @mail, @country, @city)
				end
		end
end

exec stp_customers_insert 'anand','a@b.com','india','trichy'

select * from customers

exec stp_customers_insert 'kumar','a@ab.com','india','trichy'