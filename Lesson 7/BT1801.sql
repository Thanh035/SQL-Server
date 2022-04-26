create database BT1801
use BT1801

create table Product
(
	Id int primary key identity(1,1),
	Name nvarchar(50),
	Producer nvarchar(50),
	Made_in nvarchar(20),
	Price_in money,
	Price_out money,
	Day_released date
)
go

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

create table Sell
(
	Id int primary key identity(1,1),
	Id_product int,
	foreign key(Id)
	references Product(Id),
	Note text,
	Day_sell date,
	Quantity int,
	Price_out money
)
go

insert into Sell(Id_product,Note,Day_sell,Quantity,Price_out)
values
(2, 'note 1', '2020-05-30', 2,10000),
(6, 'note 2', '2020-06-30', 3,75300),
(4, 'note 3', '2020-07-30', 1,12000),
(8, 'note 4', '2020-08-30', 1,23000),
(5, 'note 5', '2020-09-30', 4,64000),
(1, 'note 6', '2020-10-30', 3,76000),
(3, 'note 7', '2020-11-30', 1,46000),
(1, 'note 8', '2020-12-30', 5,45000),
(3, 'note 9', '2020-12-30', 3,324000),
(9, 'note 10', '2020-12-30', 1,99500)
go



--Create view :List all orders that have been sold
create view view_SoldList
as
select Product.Name,Product.Producer,Product.Day_released 
from Product inner join Sell
on Product.Id = Sell.Id_product
go

select * from view_SoldList
order by view_SoldList.Name asc
go

--List the orders sold with origin -->Write procedure:Made in
create proc proc_OrderList
@MadeIn nvarchar(50)
as
	begin
		select Product.Name,Product.Producer,Product.Day_released 
		from Product,Sell
		where Product.Id = Sell.Id_product and Product.Made_in = @MadeIn
	end
go

exec proc_OrderList 'Viet Nam'
go

--Statistics of the total selling price for each item.
--Wrie procedure (Input:Name/Output:Total)
create proc proc_Total_selling_price
@Name_product nvarchar(50),
@totalPrice money output
as
	begin
		select @totalPrice = Sum(Product.Price_out * Sell.Quantity) 
		from Product,Sell
		where Product.Id = Sell.Id_product and Product.Name = @Name_product
		group by Product.Name
	end
go

declare @totalPrice money
exec proc_Total_selling_price 'San pham 5',@totalPrice = @totalPrice output
print @totalPrice
print N'Tong tien ban duoc: '+ convert(nvarchar(50), @totalPrice)
