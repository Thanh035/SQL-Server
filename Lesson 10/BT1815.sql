---CREATE DATABASE
create database BT1815
use BT1815

-- Create tables
create table Category (
	id int primary key identity(1,1),
	name nvarchar(50) not null
)
create table Product (
	id int primary key identity(1,1),
	title nvarchar(200),
	thumbnail nvarchar(500),
	description text,
	price float,
	id_cat int references Category (id)
)
create table Staff (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	address nvarchar(200),
	email nvarchar(150),
	birthday date
)
create table Customer (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	address nvarchar(200),
	email nvarchar(150),
	birthday date,
	phone_number nvarchar(20)
)
create table Orders (
	id int primary key identity(1,1),
	staff_id int references Staff(id),
	customer_id int references Customer(id),
	total_price float,  -- Sai -> thua -> Muc dich nghiep total_price -> xu ly query simple.
	order_date datetime,
	note nvarchar(500)
)
create table OrderDetail (
	id int primary key identity(1,1),
	product_id int references Product(id),
	number int,
	price float,
	total_price float, -- Sai -> thua -> Muc dich nghiep total_price -> xu ly query simple.
	order_id int references Orders(id)
)

-- Insert Data
insert into Category (name)
values
('Cafe'),
('Sinh To')
go

insert into Product (title, thumbnail, description, price, id_cat)
values
('Cafe nong', 'Thumbnail_1', 'Noi dung 1', 32000, 1),
('Cafe da', 'Thumbnail_2', 'Noi dung 2', 32000, 1),
('Cafe sua', 'Thumbnail_3', 'Noi dung 3', 32000, 1),
('Sinh to bo', 'Thumbnail_4', 'Noi dung 4', 42000, 2),
('Sinh to mang cau', 'Thumbnail_5', 'Noi dung 5', 42000, 2)
go
insert into Staff(fullname, birthday, email, address)
values
('TRAN VAN A', '1999-01-20', 'tranvana@gmail.com', 'Ha Noi')
go
insert into Customer(fullname, birthday, email, address, phone_number)
values
('TRAN VAN B', '1990-01-20', 'tranvanb@gmail.com', 'Ha Noi', '1234567890')
go
insert into Orders(staff_id, customer_id, total_price, order_date, note)
values
(1, 1, 96000, '2021-02-26', ''),
(1, 1, 32000, '2021-02-25', ''),
(1, 1, 74000, '2021-02-27', '')
go
insert into OrderDetail(order_id, product_id, number, price, total_price)
values
(1, 1, 2, 32000, 64000),
(1, 2, 1, 32000, 32000),
(2, 1, 1, 32000, 32000),
(3, 1, 1, 32000, 32000),
(3, 5, 1, 42000, 42000)
go

--CREATE INDEX 
create index IX_PRODUCT
on Product(title,price)
go

--Create View & proc:Category  
create view Display_ProductList_Category
as
	select Category.name'Category Name',Product.title'Product Name'
	from Category,Product
	where Category.id = Product.id_cat
go
select * from Display_ProductList_Category
go

create proc Proc_ProductList_Category
@Drinks_name nvarchar(10)
as
	begin
		select Category.name,Product.title
		from Category,Product
		where Category.id = Product.id_cat
		and Category.name = @Drinks_name
	end
go

exec Proc_ProductList_Category 'Cafe'
go

--Display productList:View & Proc
create view view_ProductList
as
	select OrderDetail.id 'Order name',Category.name'Category name'
	from Category inner join Product on Category.id = Product.id_cat
				  inner join OrderDetail on Product.id = OrderDetail.product_id
go

select * from view_ProductList
go

create proc proc_ProductList
@Order_name int
as
	select OrderDetail.id 'Order name',Category.name'Category name'
	from Category inner join Product on Category.id = Product.id_cat
				  inner join OrderDetail on Product.id = OrderDetail.product_id
	where OrderDetail.id = @Order_name
go
exec proc_ProductList 5
go

--Display Order category:Id_customer
create proc proc_procduct_category
@CustomerId int
as
	begin
		select Customer.Id 'Id Customer',Customer.fullname'Customer name', Category.name'Category name'
		from Customer,Category
		where Customer.id = @CustomerId
	end
go

exec proc_procduct_category 1

--Display:Revenue Start_day&End_day ---PROCEDURE
create proc proc_RevenueByDay
@OrderDate datetime
as
	BEGIN
		select Orders.order_date 'Order datetime',SUM(Orders.total_price)'Revenue'
		from Orders
		where Orders.order_date = @OrderDate
		group by Orders.order_date
	END
go

exec proc_RevenueByDay '2021-02-26'
