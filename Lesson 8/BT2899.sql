create database BT2899
use BT2899

create table Customer
(
	Id int identity(1,1) not null,
	Fullname nvarchar(50),
	Birthdate date,
	Phone nvarchar(20),
	Email nvarchar(20),
	Points int
)
go

create table Places
(
	Id int identity(1,1) not null,
	Name nvarchar(30),
	Address nvarchar(100)
)
go

create table Tour
(
	id int identity(1,1) not null,
	Place_id int,
	Start_day date,
	End_day date,
	expense float
)
go

create table Booking
(
	Tour_id int,
	Customer_id int,
	Booking_day date,
)
go

--Create primary key	
alter table Customer 
add constraint PK_Id_Customer
primary key (Id)
go

alter table Places
add constraint PK_Id_Places
primary key (Id)
go

alter table Tour
add constraint PK_Id_Tour
primary key (Id)
go

--Create foreign key
alter table Booking
add constraint FK_Id_tour
foreign key (Tour_id)
references Tour(Id)
go

alter table Booking
add constraint FK_Id_Customer
foreign key (Customer_id)
references Customer(Id)
go

alter table Tour
add constraint FK_Id_Places
foreign key (Place_id)
references Places(Id)
go

--Add 5 data
insert into Customer(Fullname,Birthdate,Phone,Email,Points)
values
('Phung Quang A','2003-10-08','1233211','QuangA@gmail.com',89),
('Phung Quang B','2003-06-12','1233212','QuangB@gmail.com',19),
('Phung Quang C','2003-07-17','1233213','QuangC@gmail.com',56),
('Phung Quang D','2003-12-09','1233214','QuangD@gmail.com',23),
('Phung Quang E','2003-11-11','1233215','QuangE@gmail.com',93)
go

insert into Places(Name,Address)
values
('Dia danh A','Ha Noi'),
('Dia danh B','Ha Tinh'),
('Dia danh C','Nghe An'),
('Dia danh D','Da Phuc'),
('Dia danh E','Ha Nam')
go

insert into Tour(Place_id,Start_day,End_day,expense)
values
(1,'1990-10-12','1991-10-12',234),
(3,'1991-11-12','1995-10-17',2346),
(2,'1992-12-12','1995-10-14',1234),
(2,'1990-08-12','1995-10-16',11123),
(5,'1890-10-12','1891-10-05',54)
go

insert into Booking(Tour_id,Customer_id,Booking_day)
values
(1,1,'1991-08-10'),
(4,5,'1991-07-10'),
(2,3,'1991-06-10'),
(2,2,'1991-05-10'),
(5,4,'1991-04-10')
go

--create proc:tour_id
create proc proc_TourList
@tour_id int
as
	begin
		select Customer.Fullname
		from Customer,Booking
		where Customer.Id = Booking.Customer_id
		and Booking.Tour_id = @tour_id
	end
go

exec proc_TourList 4
go

--Statistics :priceTour-->Views
create view view_price_tour
as
	select Tour.id, Sum(Tour.expense) as 'Total'
	from Tour,Booking
	where Tour.id = Booking.Tour_id
	group by Tour.id
go

select * from view_price_tour
go

--Write TRIGGER don't have delete Customer
create trigger FOR_DELETE_Customer 
on Customer
for delete
as
	begin
			delete from Customer
			rollback transaction
	end
go

--Write TRIGGER dont't have edit price in Tour table
create trigger FOR_EDIT_Tour
on Tour
for update
as
	begin
		if(select count(*) from inserted) > 0
		begin
			rollback transaction
		end
	end
go

update Tour 
set expense = 99999
where id = 1
go

select * from Customer
select * from Tour
select * from Booking
select * from Places