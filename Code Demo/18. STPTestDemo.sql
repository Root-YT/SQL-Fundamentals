create table customers(custid int primary key, custname varchar(50),phone varchar(50), address varchar(250)) 

create table roomtype(roomtype varchar(50) primary key, rentperday int)

create table rooms(roomno int primary key, roomtype varchar(50), availability varchar(50))

create table allocation(custid int, roomno int, checkin datetime, checkout datetime, reasonforstay varchar(250), primary key(custid,roomno,checkin))

create table bills(billno int identity(1,1) primary key, custid int, billdate datetime, noofdays int, costperday int, total int)

--for creating roomtypes

create procedure stp_insert_roomtype(@type varchar(50), @rent int)
as
begin
	insert into roomtype values(@type, @rent)
end

exec stp_insert_roomtype 'ac',2000
exec stp_insert_roomtype 'acdeluxe',2500
exec stp_insert_roomtype 'normal',1000
exec stp_insert_roomtype 'deluxe',1500

select * from roomtype

--for creating new rooms

create procedure stp_insert_rooms(@roomno int, @type varchar(50), @availability varchar(50))
as
begin
	if exists(select roomtype from roomtype where roomtype=@type)
		begin
			insert into rooms values(@roomno, @type, @availability)
		end
	else
		begin
			raiserror('roomtype does not exist',17,1)
		end
end


exec stp_insert_rooms 1,'ac','yes'
exec stp_insert_rooms 2,'ac','yes'
exec stp_insert_rooms 3,'ac','yes'
exec stp_insert_rooms 4,'acdeluxe','yes'
exec stp_insert_rooms 5,'acdeluxe','yes'
exec stp_insert_rooms 6,'acdeluxe','yes'
exec stp_insert_rooms 7,'deluxe','yes'
exec stp_insert_rooms 8,'deluxe','yes'
exec stp_insert_rooms 9,'deluxe','yes'
exec stp_insert_rooms 10,'normal','yes'
exec stp_insert_rooms 11,'normal','yes'
exec stp_insert_rooms 12,'normal','yes'

select * from rooms

--for changing rent
create procedure changerent(@type varchar(50), @newrent int)
as
begin
	update roomtype set rentperday=@newrent where roomtype=@type
end

exec changerent 'acdeluxe',3000


--for creating customers
create procedure stp_insert_customers(@custid int, @name varchar(50), @phone varchar(50), @address varchar(250))
as
begin
	insert into customers values(@custid, @name, @phone, @address)
end

exec stp_insert_customers 1,'anand','12345','trichy'
exec stp_insert_customers 2,'karthik','2345','dindugal'
exec stp_insert_customers 3,'don','12345','trinelveli'

select * from customers


-- for booking or allocating a room
create procedure stp_insert_allocation(@custid int, @roomno int, @checkin datetime, @reasonforstay varchar(250))
as
begin
	if exists(select custid from customers where custid=@custid)
	begin
		if exists(select roomno from rooms where roomno=@roomno and availability='yes')
			begin
				insert into allocation(custid, roomno, checkin, reasonforstay) values(@custid, @roomno,@checkin, @reasonforstay)
				update rooms set availability='no' where roomno=@roomno

			end
		else
			begin
				raiserror('room not available',17,1)
		end
	end
	else
		begin
			raiserror('customer does not exist',17,1)
		end
	
end

exec stp_insert_allocation 1, 1,'20230809','admission'

select * from allocation
select * from rooms

select * from roomtype

--for vacating or checkout of a room
create procedure checkout(@custid int, @roomno int, @checkin datetime, @checkout datetime)
as
begin
	update allocation set checkout=@checkout where custid=@custid and roomno=@roomno and checkin=@checkin;
	update rooms set availability='yes' where roomno=@roomno
	declare @roomtype varchar(50)
	select @roomtype =(select roomtype from rooms where roomno=@roomno)
	declare @rentperday int
	select @rentperday= (select rentperday from roomtype where roomtype=@roomtype)
	declare @noofdays int
	select @noofdays= (select datediff(dd, @checkin, @checkout))

	insert into Bills values(@custid, getdate(), @noofdays, @rentperday, (@noofdays * @rentperday))

end

exec checkout 1, 1,'20230809','20230810'


exec stp_insert_allocation 2,4,'20230809','admission'

exec checkout 2,4,'20230809','20230811'

select * from allocation

select * from rooms

select * from bills



