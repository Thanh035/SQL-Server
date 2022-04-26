--Create database:Citykids
create database Citykids
use Citykids

--Create table
create table Zone
(
	Id int identity(1,1) primary key,
	Name nvarchar(30)
)
go

create table Game
(
	Id int identity(1,1) primary key,
	Game_name nvarchar(30),
	Zone_id int references Zone(Id),
	Price int,
	Type int,
	Percents float
)
go

create table Store
(
	Id int identity(1,1) primary key,
	Store_name nvarchar(50),
	Zone_id int references Zone(Id),
	Company_name nvarchar(50)
)
go

create table drinks
(
	Id int identity(1,1) primary key,
	Drink_name nvarchar(50),
	Price int,
	Store_id int references Store(Id)
)
go

create table ticket
(
	Id int identity(1,1) primary key,
	Price int,
	Buy_day date,
	Game_id int null references Game(Id)
)
go

create table Orders
(
	Id int identity(1,1) primary key,
	Drink_id int references drinks(Id),
	Buy_day date,
	Price int,
	Num float
)
go

--Add data
insert into Zone(Name)
values
('Zone A'),
('Zone B'),
('Zone C'),
('Zone D'),
('Zone E')
go

insert into Game(Game_name,Zone_id,Price,Type,Percents)
values
('Dragon Ball',2,12300,1,8.8),
('One Piece',5,54400,0,2.5),
('Kimetsu No yaiba',1,7800,0,3.5),
('Conan',4,9300,1,8.9)
go

insert into Store(Store_name,Zone_id,Company_name)
values
('Store A',3,'Cong ty A'),
('Store B',2,'Cong ty B'),
('Store C',1,'Cong ty C')
go

insert into drinks(Drink_name,Price,Store_id)
values
('Coca',20000,2),
('Pepsi',17000,1)
go

insert into ticket(Price,Buy_day,Game_id)
values
(54000,'2021-12-09',2),
(70000,'2021-11-09',3),
(60000,'2021-10-12',2),
(20000,'2020-12-25',1)
go

insert into Orders(Drink_id,Buy_day,Price,Num)
values
(1,'2020-12-12',37000,2),
(2,'2020-11-10',105400,5),
(1,'2020-11-18',67000,3)
go

--View:Name_zone(Zone),Name_game(Game),price,type,percents(game)
select Zone.Name,Game.Game_name,Game.Price,Game.Type,Game.Percents
from Zone inner join Game
on Zone.Id = Game.Zone_id 
go

--Create trigger Delete  info Drinks
create trigger InsteadOf_Delete_Drinks
on drinks
instead of delete
as
	begin
		delete from Orders where Id in (select Id from deleted)

		delete from drinks where Id in (select Id from deleted)
	end
go

select * from drinks

--Create trigger:No update column Price in Ticket table
create trigger FOR_UPDATE_PriceInTicket
on ticket
for update
as
	begin
		if(select count(*) from inserted where Price = 'not null' and Price = 'null') > 0
		begin
			print('No edit column Price in Ticket')
			rollback transaction
		end
	end
go

update ticket
set Price = 99999
go

select * from Zone
select * from Game
select * from Store
select * from drinks
select * from ticket
select * from Orders