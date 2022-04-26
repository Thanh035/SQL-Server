create database BT2785
use BT2785

create table Roles
(
	Id int identity(1,1) primary key,
	Rolename nvarchar(50) not null
)
go

create table Users
(
	Id int identity(1,1) primary key,
	Fullname nvarchar(50),
	Birthday date,
	Gender nvarchar(20),
	Email nvarchar(150),
	Phone_number nvarchar(20),
	Address nvarchar(200),	
)
go

create table Room
(
	Id int identity(1,1) primary key,
	Room_no nvarchar(20),
	Type nvarchar(20),
	Max_num int,
	Price FLOAT
)
go

create table Booking 
(
	Id int identity(1,1) primary key,
	Staff_id int references Users(Id),
	Customer_id int references Users(Id),
	Checkin datetime,
	Checkout datetime,
	Status int,
	Note text
)
go

create table BookingDetail
(
	Booking_id int references Booking(Id),
	Room_id int references Room(Id),
	Price float,
	Unit float
)
go

create table UserDetail
(
	Booking_id int references Booking(Id),
	Room_id int references Room(Id),
	Customer_id int references Users(Id)
)
go

create table Category
(
	Id int identity(1,1) primary key,
	Name nvarchar(50)
)
go

create table Product
(
	Id int identity(1,1) primary key,
	Category_id int references Category(Id),
	Title nvarchar(150),
	Thumbnail nvarchar(500),
	Description ntext,
	Price float,
	Amount int
)
go

insert into	Roles(Rolename)
values
('Role A'),
('Role B'),
('Role C'),
('Role D'),
('Role E')
go

insert into Users(Fullname,Birthday,Gender,Email,Phone_number,Address)
values
('Phung Quang A','2020-10-08','Nam','A@gmail.com','01233001','Ha Noi'),
('Phung Quang B','2020-03-15','Nam','B@gmail.com','01233002','Ha Noi'),
('Phung Quang C','2020-07-08','Nam','C@gmail.com','01233003','Ha Nam'),
('Phung Quang D','2020-12-29','Nam','D@gmail.com','01233004','Hai Duong'),
('Phung Quang E','2020-11-30','Nam','E@gmail.com','01233005','bac Ninh')
go

insert into Room(Room_no,Type,Max_num,Price)
values
(21,'Basic',12321,456000),
(22,'Advance',113454,945000),
(23,'Advance',57653,865000),
(24,'Basic',656534,432000),
(25,'Advance',476345,766000)
go

insert into Booking(Staff_id,Customer_id,Checkin,Checkout,Status)
values
(2,3,'2020-10-23','2020-11-23',12),
(2,2,'2020-10-23','2020-11-23',15),
(3,1,'2020-10-23','2020-11-23',17),
(4,5,'2020-10-23','2020-11-23',19),
(4,1,'2020-10-23','2020-11-23',20)
go

insert into BookingDetail(Booking_id,Room_id,Price,Unit)
values
(2,3,43200,78),
(4,1,43500,79),
(1,1,43900,80),
(5,3,84500,21),
(4,2,45900,67)
go

insert into UserDetail(Booking_id,Room_id,Customer_id)
values
(1,1,3),
(3,5,4),
(2,3,1),
(4,2,2),
(5,4,5)
go

insert into Category(Name)
values
('DV1'),
('DV2'),
('DV3'),
('DV4'),
('DV5')
go

insert into Product(Category_id,Title,Thumbnail,Description,Price,Amount)
values
(2,'TitleAS','CC','DD',43200,10),
(5,'TitleBS','CC','DD',34500,15),
(1,'TitleCS','CC','DD',213200,20),
(4,'TitleDS','CC','DD',48600,37),
(3,'TitleES','CC','DD',98600,50)
go

create table Services
(
	Id int identity(1,1) primary key,
	Customer_id int references Users(Id),
	Product_id int references Product(Id),
	Amount int,
	Price float,
	Buy_date datetime,
	Booking_id int references Booking(Id)
)
go

insert into Services(Customer_id,Product_id,Amount,Price,Buy_date,Booking_id)
values
(2,3,65,10000,'2021-10-10',1),
(5,2,66,19000,'2021-11-27',2),
(4,5,67,23000,'2021-10-05',3),
(3,4,68,90000,'2021-07-11',4),
(1,1,69,12000,'2021-05-23',5)
go

--View Info User:Name,Phone(User),Checkin,Checkout(booking),RollNo(Room)
select Users.Fullname,Users.Phone_number,Booking.Checkin,Booking.Checkout,Room.Room_no
from Users,Booking,Room
where Users.Id = Booking.Id and Room.Id = Booking.Customer_id 
go

--write proc userList to Hotel:Name,Phone(User),Checking,Checkout(Booking),RollNo(Room) -->Booking_id
create proc proc_userList
@Book_id int
as	
	begin
		select Users.Fullname,Users.Phone_number,Booking.Checkin,Booking.Checkout,Room.Room_no
		from Users,Booking,Room
		where Booking.Id = @Book_id and  Users.Id = Booking.Id and Room.Id = Booking.Customer_id 
	end
go

exec proc_userList 2
go

--Calculator Sum(booking) -->Booking_id
create proc proc_Sum_booking
@booking_id int
as
	begin
		select Room.Room_no,sum(BookingDetail.Price)'Sum booking_price'
		from Room,BookingDetail,Booking
		where Room.Id=BookingDetail.Room_id 
		and Booking.Id = BookingDetail.Booking_id 
		and Booking.Id = @booking_id
		group by Room.Room_no
	end
go

exec proc_Sum_booking 2

--Proc:sum(services) -->booking_id
create proc proc_Sum_services
@booking_id int
as
	begin
		select Booking.Id,sum(Services.Price) 'Sum_services_price'
		from Booking,Services
		where Booking.Id = @booking_id
		group by Booking.Id
	end
go

exec proc_Sum_services 2

--Proc:Sum(Services+Booking) -->booking_id
create proc Sum_Services_Booking_Price
@bookingId int
as
	begin
		select Booking.Id,sum(BookingDetail.Price+Services.Price*Services.Amount) as Total
		from Booking,BookingDetail,Services
		where Booking.Id = @bookingId
		and BookingDetail.Booking_id = Booking.Id
		and Services.Booking_id = Booking.Id
		group by Booking.Id
	end
go

exec Sum_Services_Booking_Price 2

--Calculator Sum_ServicesByUser:Name(User),Phone(User),Total(Sum)
create view Sum_servicesByUser
as
select Users.Fullname,Users.Phone_number,Sum(Services.Price) as Total
from Users,Services
where Services.Customer_id = Users.Id
group by Users.Fullname,Users.Phone_number
go 

select * from Sum_servicesByUser
go

