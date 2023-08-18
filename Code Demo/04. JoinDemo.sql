create table customers(cid int primary key, cname varchar(50),  cphone varchar(50))

create table orders(oid int primary key, cid int, product varchar(50), quantity int)

--inserting sample values

insert into customers values(1,'anand','12345')
insert into customers values(2,'kumar','44444')
insert into customers values(3,'raja','55555')
insert into customers values(4,'arun','66666')
insert into customers values(5,'karthik','77777')

select * from customers

insert into orders values(1,1,'pencil',100)
insert into orders values(2,1,'pen',100)
insert into orders values(3,1,'scale',500)

insert into orders values(4,2,'mouse',10)
insert into orders values(5,2,'keyboard',10)

insert into orders values(6,3,'scale',500)
insert into orders values(7,3,'pencil',1000)
insert into orders values(8,3,'eraser',500)

insert into orders values(9,6,'monitor',5)
insert into orders values(10,7,'cabinet',15)

select * from orders

--Join Statements

--cross join

select * from customers c cross join orders o

--cross join differently

select * from customers, orders

--Inner Join

--cross join with condition(a inner join)

select * from customers c cross join orders o where c.cid= o.cid

-- a simple inner join

select * from customers join orders on customers.cid= orders.cid

-- another way for inner join without join keyword
select * from customers, orders where customers.cid= orders.cid

--another way for inner join
select * from customers c inner join orders o on c.cid= o.cid

-- show only selective columns using a join
select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c join orders o on c.cid=o.cid


--Outer Join

--left join

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c left join orders o on c.cid=o.cid

--right join

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c right join orders o on c.cid=o.cid

--right join with inverted table names

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from orders o right join customers c on c.cid=o.cid

--Full join

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c full join orders o on c.cid=o.cid

--full join useful for administration (customers who have placed no orders)

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c full join orders o on c.cid=o.cid where o.oid is null

-- full join useful for administration  (orders having no customer details)

select c.cid as CustId, c.cname as Name,c.cphone as Phone, o.oid as OrderId, o.product as Product, o.quantity as Quantity from customers c full join orders o on c.cid=o.cid where c.cid is null
