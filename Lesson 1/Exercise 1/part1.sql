--tao va su dung data
create database part1
use part1

--Tao bang
create table Customer(
  Cust_No int,
  Cust_Name nvarchar(50),
  PhoneNo nvarchar(11)
)
create table Items(
  Item_No nvarchar(10),
  Description nvarchar(50),
  Price int 
)
create table Order_Details(
  Ord_No int,
  Item_No nvarchar(10),
  Qty int
)
create table Order_August(
  Ord_No int,
  Ord_Date Datetime,
  Cust_No int
)

--Add data vao bang
insert into Customer (Cust_No,Cust_Name,PhoneNo)
values
(1,'David Gordon','0231-5466356'),
(2,'Prince Fernandes','0221-5762382'),
(3,'Charles Yale','0321-8734723'),
(4,'Ryan Ford','0241-2343444'),
(5,'Bruce Smith','0241-8472198');
insert into Items(Item_No,Description,Price)
values
('HW1','Power Supply',4000),
('HW2','Keyboard',2000),
('HW3','Mouse',800),
('HW4','Office Suite',15000),
('HW5','Payroll Software',8000);
insert into Order_Details(Ord_No,Item_No,Qty)
values
(101,'HW3',50),
(101,'SW1',150),
(102,'HW2',10),
(103,'HW3',50),
(104,'HW2',25),
(104,'HW3',100),
(105,'SW1',100);
insert into Order_August(Ord_No,Ord_Date,Cust_No)
values
(101,'02-08-12',1),
(102,'11-08-12',2),
(103,'21-08-12',3),
(104,'28-08-12',4),
(105,'30-08-12',5);

--Display data
select *from Customer
select *from Items
select *from Order_Details
select *from Order_August