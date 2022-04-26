create database BT1844
use BT1844

--Create 5 table
create table Student
(
	Id int identity(1,1) primary key,
	Fullname nvarchar(50),
	Address nvarchar(100),
	Father_name nvarchar(50),
	Mother_name nvarchar(50),
	Father_phone nvarchar(20),
	Mother_phone nvarchar(20),
	Birthdate date,
	Gender nvarchar(7),
	Position_id int
)
go

create table Bus
(
	Id int identity(1,1) primary key,
	Bus_no nvarchar(20),
	Type nvarchar(15),
	SeatsNum int,
	Driver_id int
)

create table Driver
(	
	Id int identity(1,1) primary key,
	Name nvarchar(50),
	Phone nvarchar(20),
	Gender nvarchar(10),
	Address nvarchar(100)
)

create table BusTravel
(
	Bus_id int,
	Position_id int
)
go

create table Position
(	
	Id int identity(1,1) primary key,
	Address nvarchar(100)
)
go

alter table BusTravel
add foreign key (Bus_id)
references Bus(Id)
go

alter table BusTravel
add foreign key (Position_id)
references Position(Id)
go

alter table Student
add foreign key (Position_id)
references Position(Id)
go

--Add Data
insert into Student(Fullname,Address,Father_name,Mother_name,Father_phone,Mother_phone,Birthdate,Gender,Position_id)
values
('Hoc sinh A', 'Ha Noi' , 'A1', 'A2', '123331', '212312', '2018-02-03', 'Male ', 1),
('Hoc sinh B', 'Soc Son', 'B1', 'B3', '132213', '233123', '2018-01-03', 'Female', 2),
('Hoc sinh C', 'Phu Tho', 'C1', 'C3', '123321', '233312', '2018-03-03', 'Male',  3),
('Hoc sinh D', 'Da Phuc', 'D1', 'D3', '124323', '233132', '2018-06-03', 'Male',   1),
('Hoc sinh E', 'Sai Gon', 'E1', 'E3', '123123', '233312', '2018-09-03', 'female',  2)
go

insert into Bus(Bus_no,Type,SeatsNum,Driver_id)
values
('R001', 1, 20, 1),
('R002', 2, 20, 2),
('R003', 3, 20, 2),
('R004', 4, 20, 2),
('R005', 5, 20, 3)
go
insert into Driver(Name,Phone,Gender,Address)
values
('Tran Van A','0371465787','Male','Linh Nam'),
('Tran Van B','0371465797','Female','Nam Dinh'),
('Tran Van C','0371465757','Male','Ha Tinh'),
('Tran Van D','0371465767','Female','Thanh Hoa'),
('Tran Van E','0371465787','Male','Nghe An')
go

insert into BusTravel(Bus_id,Position_id)
values
(1,2),
(2,2),
(2,1),
(1,1),
(3,4)
go

insert into Position(Address)
values
('Hai Duong'),
('Ha Noi'),
('Phu Quoc'),
('Nam Dinh'),
('Bac Giang')
go

select * from Student
select * from Bus
select * from Driver
select * from Position
select * from BusTravel


--create view Bus Route:Driver(Driver),Bus_No(Bus),Address(position)
create view view_BusRoute
as
select Driver.Name,Bus.Bus_no,Position.Address
from Driver,Bus,Position,BusTravel
where Bus.Driver_id = Driver.Id		
	and Position.Id = BusTravel.Position_id
	and Bus.Id = BusTravel.Bus_id
go

select * from view_BusRoute

--create proc Information Student by Bus_no
create proc proc_InforStudent
@Bus_no nvarchar(10)
as
	begin
		select Bus.Bus_no,Student.Fullname,Student.Address,Student.Birthdate,Student.Gender
		from Student,Bus,BusTravel 
		where Bus.Id = BusTravel.Bus_id 
		and BusTravel.Position_id = Student.Position_id 
		and Bus.Bus_no = @Bus_no
	end
go

exec proc_InforStudent 'R002'

--Create view information student :Name Student(Student),Gender(Student),Address(Student)
create view view_Information_StudentList
as 
select Student.Fullname,Student.Gender,Student.Address
from Student
go

select * from view_Information_StudentList