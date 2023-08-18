-- Triggers 

-- Sample Tables

create table students(studid int primary key, studname varchar(50), status varchar(50))

insert into students values(1,'anand1','active')
insert into students values(2,'anand2','active')
insert into students values(3,'anand3','active')
insert into students values(4,'anand4','active')

select * from students

delete from students where studid=3

select * from deleted

--DML Triggers Demo

--Default Template
--create/alter trigger Triggername on Tablename for/instead of  delete/insert/update
--as
--begin
--statements--
--end

--After Trigger--

--don't allow delete instead view contents of deleted table
create trigger trg_students_delete on students for delete
as
begin
	select * from deleted
	rollback transaction
end


--don't allow deletetion of multiple entries
alter trigger trg_students_delete on students for delete
as
begin
	if(select count(*) from deleted)>1
	begin
		raiserror('cannot delete multiple entries',17,1)
		rollback transaction
	end
end

--to drop the existing trigger
drop trigger trg_students_delete


--AFTER INSERT Perform Insert on Related Tables

create table newstudents(rollno int identity(1,1) primary key, studname varchar(50), studphone varchar(10))

create table LibAccounts(libcardno int identity(1,1) primary key, rollno int, Possiblecount int, currentcount int)

create trigger trg_newstudents_insert on newstudents for insert
as
begin
declare @rollno int
set @rollno = (select rollno from inserted)
insert into LibAccounts values(@rollno, 4, 0)
end

insert into newstudents values('anand', '12345')

select * from newstudents

select * from LibAccounts

insert into newstudents values('kumar', '12345')
insert into newstudents values('arun', '12345')


--Instead of Trigger--

--an instead of trigger to change status to discontinued when deleted

create trigger trg_students_insteadofdelete on students instead of delete
as
begin
	update students set status='discontinued'
end

drop trigger trg_students_insteadofdelete

delete from students where studid=2

select * from students

truncate table students

-- correct update trigger using deleted table
alter trigger trg_students_insteadofdelete on students instead of delete
as
begin
	update students set status='discontinued' from deleted join students on deleted.studid=students.studid
end


--INSTEAD OF INSERT - UPDATE

create table BillDetails(billno int, productid int, product varchar(50), quantity int, primary key(billno, productid))

Create trigger trg_BillDetails_insert on BillDetails instead of insert
as
begin

	declare @billno int
	set @billno = (select inserted.billno from inserted)
	declare @productid int
	set @productid = (select inserted.productid from inserted)
	declare @qty int
	set @qty = (select inserted.quantity from inserted)
	declare @product varchar(50)
	set @product= (select inserted.product from inserted)

	if exists(select * from billdetails where productid= @productid and billno=@billno)
	begin
		declare @cqty int
		set @cqty = (select quantity from billdetails where productid=@productid and billno=@billno)
		update BillDetails set Quantity=(@qty +@cqty) where billno=@billno and productid=@productid
	end
else
	begin
		insert into billdetails values(@billno, @productid, @product, @qty)
	end
end

select * from billdetails

insert into billdetails values(1, 101, 'pen', 5)

insert into billdetails values(2, 101, 'pen', 10)

insert into billdetails values(1, 101, 'pen', 6)

truncate table billdetails

--DDL Triggers Demo
--Default Template

--create/alter trigger Triggername on database/server for Drop_Table --(Create or alter on Table, Procedure, Trigger...)
--as
--begin
---Statements---
--end


--no instead of triggers in DDL

--trigger to block table drop

create trigger trg_ddl_blockdrop on database for Drop_Table
as
begin
	raiserror('You cannot drop tables',16,1)
	rollback transaction
end

create table emp(empid int)

drop table emp

create table logevents(logid int identity(1,1) primary key, logevent xml)

select * from logevents

--trigger to log create table events

create trigger trg_logevents on database for create_Table
as
begin
	declare @action xml
	set @action=Eventdata()
	insert into logevents values(@action)
end

create table emp1(empid int)

create table stud1(studid int, studname varchar(50))

select * from logevents

-- trigger to log all database level ddl statements
alter trigger trg_logevents on database for ddl_database_level_events
as
begin
	declare @action xml
	set @action=Eventdata()
	insert into logevents values(@action)
end

create table Demo(did int)

select * from logevents

drop trigger trg_ddl_blockdrop on database

drop table Demo

select * from logevents