--tao va su dung data
create database part1
use part1

--Tao bang
create table Customer(
  Cust_No int,
  Cust_Name nvarchar(50),
  PhoneNo nvarchar(11)
)
go

create table Items(
  Item_No nvarchar(10),
  Description nvarchar(50),
  Price int 
)
go

create table Order_Details(
  Ord_No int,
  Item_No nvarchar(10),
  Qty int
)
go

create table Order_August(
  Ord_No int,
  Ord_Date Datetime,
  Cust_No int
)
go

--Add data vao bang
insert into Customer (Cust_No,Cust_Name,PhoneNo)
values
(1,'David Gordon','023-543'),
(2,'Prince Fernandes','021-382'),
(3,'Charles Yale','031-723'),
(4,'Ryan Ford','021-244'),
(5,'Bruce Smith','041-898');
go

insert into Items(Item_No,Description,Price)
values
('HW1','Power Supply',4000),
('HW2','Keyboard',2000),
('HW3','Mouse',800),
('HW4','Office Suite',15000),
('HW5','Payroll Software',8000)
go

insert into Order_Details(Ord_No,Item_No,Qty)
values
(101,'HW3',50),
(101,'SW1',150),
(102,'HW2',10),
(103,'HW3',50),
(104,'HW2',25),
(104,'HW3',100),
(105,'SW1',100)
go

insert into Order_August(Ord_No,Ord_Date,Cust_No)
values
(101,'2002-08-12',1),
(102,'2011-08-12',2),
(103,'2021-08-12',3),
(104,'2028-08-12',4),
(105,'2030-08-12',5);
go

--Display data
select *from Customer
select *from Items
select *from Order_Details
select *from Order_August

alter 