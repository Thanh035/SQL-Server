--Create database
create database TEXT1801
use TEXT1801

--Table creation  
create table Product
(
	Id int identity(1,1) primary key,
	Name nvarchar(50),
	Producer nvarchar(20),
	Made_in nvarchar(20),
	Price_in money,
	Price_out money,
	Day_released date
)
go 
create table Sell
(
	Order_id int identity(1,1) primary key,
	Product_id int references Product(Id),
	Note text,
	Day_sell date,
	Quantity int,
	Price money
)
go

--Insert data
insert into Product(Name,Producer,Made_in,Price_in,Price_out,Day_released)
values
('San pham 1', 'ABC', 'Viet Nam', 20000, 50000, '2021-01-05'),
('San pham 2', 'ABC', 'Viet Nam', 10000, 50000, '2021-01-05'),
('San pham 3', 'GokiSoft', 'Viet Nam', 40000, 50000, '2021-01-05'),
('San pham 4', 'ABC', 'JP', 20000, 50000, '2021-01-05'),
('San pham 5', 'GokiSoft', 'Viet Nam', 20000, 50000, '2021-01-05'),
('San pham 6', 'GokiSoft', 'JP', 30000, 50000, '2021-01-05'),
('San pham 7', 'GokiSoft', 'Viet Nam', 20000, 50000, '2021-01-05'),
('San pham 8', 'ABC', 'JP', 20000, 50000, '2021-01-05'),
('San pham 9', 'ABC', 'JP', 20000, 50000, '2021-01-05'),
('San pham 10', 'GokiSoft', 'Lao', 20000, 50000, '2021-01-05')
go
insert into Sell(Product_id,Note,Day_sell,Quantity,Price)
values
(1,'Hang moi 100%','10-10-2020',3,23000),
(2,'Hang moi 100%','10-10-2020',1,45000),
(3,'Hang moi 100%','10-10-2020',5,67000),
(1,'Hang moi 100%','10-10-2020',2,78000),
(4,'Hang moi 100%','10-10-2020',7,12000),
(5,'Hang moi 100%','10-10-2020',5,39000),
(4,'Hang moi 100%','10-10-2020',2,76500),
(6,'Hang moi 100%','10-10-2020',9,35000),
(7,'Hang moi 100%','10-10-2020',1,55000),
(5,'Hang moi 100%','10-10-2020',6,88000)
go

--Display all order have buy :View
create view view_All_Order
as
	select Sell.Order_id,Product.Name,Sell.Day_sell
	from Sell,Product
	where Product.Id = Sell.Product_id
go
select * from view_All_Order
go

--Display all order have made in -->Proc:madein
create proc proc_All_Order
@MadeIn nvarchar(20)
as
	begin
		select Sell.Order_id,Product.Name,Sell.Day_sell,Product.Made_in
		from Sell,Product
		where Product.Id = Sell.Product_id 
		and Product.Made_in = @MadeIn
	end
go
exec proc_All_Order 'Viet Nam'
go

--Statistic of the Total selling price of each item -->Proc:Input(product),Output(Total)
create proc proc_Total_Selling_Price
@ProductId int,
@Total money output
as
	begin
		select Product.Id,Product.Name,SUM(Product.Price_out) as Total
		from Product,Sell
		where Product.Id = Sell.Product_id
		and Product.Id = @ProductId
		group by Product.Id,Product.Name
	end
go
declare @Total money
exec proc_Total_Selling_Price 1,@Total = @Total output
go
